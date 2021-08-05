import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/pages/booking_details.dart';

class MyBookingsList extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final Models model;

  MyBookingsList({@required this.snapshot, @required this.model});

  deleteAlert(
      BuildContext _context, Models model, String id, String collectionId) {
    return showDialog(
      context: _context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(8),
        title: Text(
          'WARNING!',
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
            "We can't confirm your booking if you delete this.\nContinue?"),
        actions: [
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: EdgeInsets.all(5),
                color: Colors.green,
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              )),
          GestureDetector(
              onTap: () {
                // model.deleteBookedRoom(id, collectionId);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                color: Colors.red,
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }

  _listBuilder() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          trailing: GestureDetector(
            onTap: () {},
            // => deleteAlert(
            //     context,
            //     model,
            //     snapshot.data.docs[index].id,
            //     snapshot.data.docs[index]['collectionId']),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(snapshot.data.docs[index]['hotelName']),
          subtitle: Text(snapshot.data.docs[index]['roomNumber']),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyBookingDetails(
                  noOfDays: snapshot.data.docs[index]['noOfDays'],
                  price: snapshot.data.docs[index]['price'],
                  checkOut: snapshot.data.docs[index]['checkOut'],
                  checkIn: snapshot.data.docs[index]['checkIn'],
                  bookRef: snapshot.data.docs[index]['bookRef'],
                  hotelName: snapshot.data.docs[index]['hotelName'],
                  roomNumber: snapshot.data.docs[index]['roomNumber'],
                  collectionId: snapshot.data.docs[index]['collectionId'],
                  id: snapshot.data.docs[index].id,
                  model: model,
                  // deleteFunction: deleteAlert,
                ),
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
      ),
      body: snapshot.data.docs.isEmpty
          ? Center(child: Text('No Bookings Yet'))
          : _listBuilder(),
    );
  }
}

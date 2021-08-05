import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/pages/room_view_page.dart';

class HotelRoomPage extends StatefulWidget {
  final String collectionId;
  final Models model;
  final String hotelName;

  HotelRoomPage(
      {@required this.hotelName,
        @required this.model,
        @required this.collectionId});

  @override
  _HotelRoomPageState createState() => _HotelRoomPageState();
}

class _HotelRoomPageState extends State<HotelRoomPage> {
  Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  var currency = utf8.decode([0xE2, 0x82, 0xA6]);

  @override
  void initState() {
    super.initState();
    widget.model
        .fetchHotelRooms()
        .then((value) => stream = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hotelName),
      ),
      body: ScopedModelDescendant<Models>(
          builder: (context, child, Models model) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: stream,
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView.builder(
                        itemCount: snapshot.data.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return _buildRooms(
                            collectionId: widget.collectionId,
                            title: snapshot.data.docs[index]['title'],
                            roomNumber: snapshot.data.docs[index]['roomNumber'],
                            price: snapshot.data.docs[index]['price'],
                            image: snapshot.data.docs[index]['image'],
                            description: snapshot.data.docs[index]['details'],
                            roomId: snapshot.data.docs[index].id,
                            checkOut: snapshot.data.docs[index]['checkOut'],
                            checkIn: snapshot.data.docs[index]['checkIn'],
                          );
                        });
                  } else {
                    return Center(
                      child: Container(child: Text('No Room Yet')),
                    );
                  }
                });
          }),
    );
  }

  Widget _buildRooms({
    String roomNumber,
    String checkIn,
    String checkOut,
    String image,
    String title,
    String price,
    String description,
    String collectionId,
    String roomId,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomViewPage(
              isHouse: false,
              title: title,
              description: description,
              image: image,
              price: price,
              edit: false,
              isHotel: true,
              roomNumber: roomNumber,
              collectionId: collectionId,
              roomId: roomId,
              checkIn: checkIn,
              hotelName: widget.hotelName,
              checkOut: checkOut,
            ),
          )),
      child: Container(
        child: Material(
          elevation: 10,
          shadowColor: Colors.blueGrey,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(image),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Text(
                        '$currency$price',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(description),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

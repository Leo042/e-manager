import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spot_manager/hotels/view_hotel_rooms.dart';
import 'package:spot_manager/models/models.dart';

class Hotels extends StatefulWidget {
  final Models model;

  Hotels({this.model});

  @override
  _HotelsState createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  fetch() {
    widget.model.fetchHotels().then((value) {
      stream = value;
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: stream,
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : snapshot.data == null ||
                        snapshot.hasData != true ||
                        snapshot.data.size < 1
                    ? Center(
                        child: Text(
                          'No hotels yet',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : snapshot.hasData
                        ? GridView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HotelRoomPage(
                                          collectionId: snapshot
                                              .data.docs[index]['collectionId'],
                                          model: widget.model,
                                          hotelName: snapshot.data.docs[index]
                                              ['name'],
                                        ),
                                      )),
                                  child: _hotelBuilder(snapshot.data, index));
                            },
                          )
                        : Center(
                            child: Column(
                              children: [
                                Text('problem occurred'),
                                GestureDetector(
                                  onTap: () => fetch(),
                                  child: Row(
                                    children: [
                                      Text('tap to reload'),
                                      Icon(Icons.refresh),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
          }),
    );
  }

  _hotelBuilder(QuerySnapshot data, int index) {
    return Material(
      shadowColor: Colors.blueGrey,
      elevation: 10,
      child: Column(
        children: [
          Material(
            type: MaterialType.circle,
            child: Image.network(
              data.docs[index]['logo'],
              alignment: Alignment.center,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(data.docs[index]['name'], textAlign: TextAlign.center),
                Text(data.docs[index]['area'], textAlign: TextAlign.center),
              ],
            ),
          )
        ],
      ),
    );
  }
}

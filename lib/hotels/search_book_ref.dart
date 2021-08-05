import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/pages/room_view_page.dart';

class SearchBookRef extends StatefulWidget {
  final Models models;
  final String collectionId;
  final bool searchRoom;
  final bool searchCode;
  final String onComplete;
  final String hint;

  SearchBookRef(
      {this.hint,
        this.searchRoom,
        this.models,
        this.collectionId,
        this.searchCode, this.onComplete});

  @override
  _SearchBookRefState createState() => _SearchBookRefState();
}

class _SearchBookRefState extends State<SearchBookRef> {
  TextEditingController controller = TextEditingController();

  Stream<QuerySnapshot> stream;

  search(String search, String collectionId) {
    if (widget.searchRoom == true) {
      widget.models.searchRoom(search, collectionId).then((value) {
        value.forEach((element) {
          element.docs.forEach((element) {
            widget.models.fetchSearchedRoom(collectionId, element.id);
          });
        });
        setState(() {
          stream = value;
        });
      });
    } else {
      widget.models.searchRefCode(search, collectionId).then((value) {
        value.forEach((element) {
          element.docs.forEach((element) {
            widget.models.fetchSearchedRoom(collectionId, element.id);
          });
        });
        setState(() {
          stream = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              alignment: Alignment.topCenter,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: controller,
                onChanged: (value) {
                  if(value.length < 12){
                    Future.delayed(Duration(seconds: 2),
                        search(controller.text, widget.collectionId));
                  }
                },
                decoration: InputDecoration(
                  hintText: '${widget.hint}',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      search(controller.text, widget.collectionId);
                    },
                    child: Container(
                        padding: EdgeInsets.all(3),
                        child: Icon(
                          Icons.search,
                          color: Colors.blue,
                        )),
                  ),
                  prefixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.clear();
                      });
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 45),
            ScopedModelDescendant<Models>(
                builder: (context, child, Models model) {
                  return StreamBuilder<QuerySnapshot>(
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RoomViewPage(
                                      isHouse: false,
                                      collectionId: widget.collectionId,
                                      title: model.hotelRooms[index].title,
                                      price: model.hotelRooms[index].price,
                                      description: model.hotelRooms[index].details,
                                      image: model.hotelRooms[index].image,
                                      roomNumber: model.hotelRooms[index].roomNumber,
                                      isSearch: widget.searchCode,
                                      searchRoom: widget.searchRoom,
                                      checkOut: model.hotelRooms[index].checkOut,
                                      checkIn: model.hotelRooms[index].checkIn,
                                      noOfDays: model.hotelRooms[index].noOfDays,
                                      available:
                                      model.hotelRooms[index].available != null
                                          ? model.hotelRooms[index].available
                                          : model.hotelRooms[index].checkOut != null
                                          ? (DateTime.tryParse(model
                                          .hotelRooms[index]
                                          .checkIn)
                                          .isBefore(
                                          DateTime.now()) ==
                                          true &&
                                          DateTime.tryParse(model
                                              .hotelRooms[index]
                                              .checkOut)
                                              .isBefore(
                                              DateTime.now()) ==
                                              true)
                                          ? false
                                          : true
                                          : true,
                                    ),
                                  )),
                              child: ListTile(
                                title: widget.searchRoom == true
                                    ? snapshot.data.docs[index]['roomNumber']
                                    : snapshot.data.docs[index]['name'],
                                subtitle: widget.searchRoom == true
                                    ? snapshot.data.docs[index]['title']
                                    : snapshot.data.docs[index]['roomNumber'],
                              ),
                            );
                          });
                        }
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data.docs.length < 1) {
                          return Center(
                            child: Container(
                              child: Text(widget.onComplete),
                            ),
                          );
                        } else {
                          return Center(
                            child: Container(
                              child: Text('Enter search text'),
                            ),
                          );
                        }
                      });
                }),
          ],
        )
      ],
    );
  }
}

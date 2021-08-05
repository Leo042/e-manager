import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_manager/models/models.dart';

class HotelPage extends StatefulWidget {
  final String name;
  final String collectionId;
  final Models models;
  final bool isManager;

  HotelPage({this.isManager, this.models, this.name, this.collectionId});

  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  Stream<QuerySnapshot> stream;

  fetchManagers(String collectionId) {
    widget.models.fetchHotelManagers(collectionId).then((value) {
      setState(() {
        stream = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchManagers(widget.collectionId);
  }

  onTap(String managerId) {
    if (widget.isManager == true) {
      return null;
    } else {
      widget.models.removeManager(widget.collectionId, managerId);
      fetchManagers(widget.collectionId);
    }
  }

  SingleChildScrollView dataTable(QuerySnapshot data) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('Managers'),
          ),
          DataColumn(
            label: Text('Number'),
          ),
          DataColumn(
            label: Text(''),
          ),
        ],
        rows: data.docs
            .map(
              (e) => DataRow(cells: [
                DataCell(
                  Text(e['name']),
                ),
                DataCell(
                  Text(e['number']),
                ),
                DataCell(
                  Row(
                    children: [
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.all(8),
                        child: Text(widget.isManager == true ? '' : 'Remove'),
                      ),
                    ],
                  ),
                  onTap: () {
                    if (widget.isManager == true) {
                      return null;
                    } else {
                      onTap(e['managerId']);
                    }
                  },
                ),
              ]),
            )
            .toList(),
      ),
    );
  }

  navigate(Widget page) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: stream,
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Container(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        return dataTable(snapshot.data);
                      } else {
                        return widget.isManager == true
                            ? GestureDetector(
                                onTap: () => fetchManagers(widget.collectionId),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                        'An error occurred!\nTap to refresh.'),
                                  ),
                                ),
                              )
                            : Container(
                                child: GestureDetector(
                                  onTap: () {},
                                  // => navigate(
                                  //   AddHotelManager(
                                  //     collectionId: widget.collectionId,
                                  //     models: widget.models,
                                  //   ),
                                  // ),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      color: Colors.green,
                                      child: Text('Add Manager'),
                                    ),
                                  ),
                                ),
                              );
                      }
                    },
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    // => navigate(
                    //   HotelRoomPage(
                    //       hotelName: widget.name,
                    //       model: widget.models,
                    //       collectionId: widget.collectionId),
                    // ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.green,
                      child: Center(child: Text('View Rooms')),
                    ),
                  ),
                  SizedBox(width: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        // => navigate(
                        //   AddHotelManager(
                        //     collectionId: widget.collectionId,
                        //     models: widget.models,
                        //   ),
                        // ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.green,
                          child: Center(child: Text('Add Manager')),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        // => navigate(AddHotelRooms(
                        //   collectionId: widget.collectionId,
                        //   isManager: widget.isManager,
                        // )),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.green,
                          child: Center(child: Text('Add Hotel Rooms')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spot_manager/hotels/hotel_page.dart';
import 'package:spot_manager/hotels/search_book_ref.dart';
import 'package:spot_manager/models/models.dart';

class MyHotelTab extends StatefulWidget {
  final String name;
  final String collectionId;
  final Models models;
  final bool isManager;

  MyHotelTab({this.models, this.name, this.collectionId, this.isManager});

  MyHotelTabState createState() => MyHotelTabState();
}

class MyHotelTabState extends State<MyHotelTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.hotel),
                  text: 'My Hotel',
                ),
                Tab(
                  icon: Icon(Icons.search),
                  text: 'Search Booking Code',
                ),
                Tab(
                  icon: Icon(Icons.room),
                  text: 'Search Room',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HotelPage(
                isManager: widget.isManager,
                collectionId: widget.collectionId,
                name: widget.name,
                models: widget.models,
              ),
              SearchBookRef(
                models: widget.models,
                hint: 'Enter booking code..',
                collectionId: widget.collectionId,
                searchCode: true,
                onComplete: 'Booking code does not exist',
              ),
              SearchBookRef(
                models: widget.models,
                collectionId: widget.collectionId,
                searchRoom: true,
                hint: 'Enter room number..',
                onComplete: 'Room number does not exist',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

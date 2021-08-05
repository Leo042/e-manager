import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/hotels/hotel_tab.dart';
import 'package:spot_manager/models/models.dart';

class OwnersHotelList extends StatefulWidget {
  final Models models;
  final Function function;
  final bool isManager;
  final String ownerNumber;

  OwnersHotelList(
      {this.isManager, this.ownerNumber, this.models, @required this.function});

  @override
  _OwnersHotelListState createState() => _OwnersHotelListState();
}

class _OwnersHotelListState extends State<OwnersHotelList> {
  @override
  void initState() {
    super.initState();
    widget.function(widget.ownerNumber);
  }

  @override
  Widget build(BuildContext context) {
    widget.function(widget.ownerNumber);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Hotels'),
      ),
      body: ScopedModelDescendant<Models>(
          builder: (context, child, Models model) {
        return model.myHotels.isEmpty
            ? Center(
                child: Text('No hotels yet'),
              )
            : ListView.builder(itemBuilder: (context, index) {
                return GestureDetector(
                  child: _listTile(index, model),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHotelTab(
                          models: model,
                          name: model.myHotels[index].hotelName,
                          collectionId: model.myHotels[index].collectionId,
                        ),
                      )),
                );
              });
      }),
    );
  }

  Widget _listTile(int index, Models model) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(model.myHotels[index].hotelLogo),
      ),
      title: Text(model.myHotels[index].hotelName),
      subtitle: Text('Tap For More Details'),
    );
  }
}

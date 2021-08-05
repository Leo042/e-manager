import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/add_owners_and_services/add_hotel_owners.dart';
import 'package:spot_manager/hotels/hotel_owner_list.dart';
import 'package:spot_manager/models/models.dart';

class HotelOwnersPage extends StatefulWidget {
  final Models model;

  HotelOwnersPage(this.model);

  @override
  _HotelOwnersPageState createState() => _HotelOwnersPageState();
}

class _HotelOwnersPageState extends State<HotelOwnersPage> {
  fetchHotels(String number) {
    widget.model.fetchHotels(number);
  }

  @override
  void initState() {
    super.initState();
    widget.model.fetchHotelOwners();
  }

  Text _text(String text) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.w400));
  }

  Widget listBuilder(int index, Models model) {
    model.fetchHotelOwners();
    Container _border = new Container(
      width: double.infinity,
      height: 1.0,
      color: Theme.of(context).primaryColor,
    );
    return Column(children: [
      ListTile(
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddHotelOwner(
                  name: model.hotelsOwners[index].name,
                  area: model.hotelsOwners[index].area,
                  location: model.hotelsOwners[index].location,
                  logo: model.hotelsOwners[index].logo,
                  ownerName: model.hotelsOwners[index].ownerName,
                  ownerNumber: model.hotelsOwners[index].ownerNumber,
                  collectionId: model.hotelsOwners[index].collectionId,
                  id: model.hotelsOwners[index].id,
                  edit: true,
                ),
              )),
        ),
        title: Text(
          model.hotelsOwners[index].ownerName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          children: [
            _text(model.hotelsOwners[index].ownerName),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OwnersHotelList(
                    function: fetchHotels,
                    models: model,
                    ownerNumber: model.hotelsOwners[index].ownerNumber),
                //     ContactUs(
                //   chatRoomId: model.chatUsers[index].chatRoomId,
                //   userName: model.chatUsers[index].userName,
                // ),
              ));
        },
      ),
      _border,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    widget.model.fetchHotelOwners();
    return ScopedModelDescendant<Models>(
        builder: (context, child, Models model) {
          return Scaffold(
        appBar: AppBar(
          title: Text('Hotel Owners'),
        ),
        body: Container(
          child: model.hotelsOwners.isEmpty
              ? Center(
                  child: Text('Nothing yet'),
                )
              : ListView.builder(
                  itemCount: model.hotelsOwners.length,
                  itemBuilder: (context, index) {
                    return listBuilder(index, model);
                  },
                ),
        ),
      );
    });
  }
}

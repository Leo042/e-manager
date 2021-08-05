import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/pages/room_view_page.dart';
import 'package:spot_manager/post_and_updates/agent_update.dart';
import 'package:spot_manager/post_and_updates/update_goods_restaurants.dart';

class MyUploads extends StatefulWidget {
  final Models models;
  MyUploads({this.models});

  @override
  _MyUploadsState createState() => _MyUploadsState();
}

class _MyUploadsState extends State<MyUploads> {
  @override
  void initState() {
    super.initState();
    widget.models.authenticate();
  }

  _buildListTile(int index, Models model) {
    widget.models.authenticate();
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(model.products[index].image),
      ),
      title: Text(
        model.products[index].title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Tap for more details',
          style: TextStyle(fontWeight: FontWeight.w400)),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => model.products[index].location == null
              // model.products[index].location == 'Properties&Goods'
                  ? UpdateGoodsRestaurant(
                description: model.products[index].description,
                edit: true,
                houseId: model.products[index].id,
                image: model.products[index].image,
                price: model.products[index].price,
                title: model.products[index].title,
                type: model.products[index].type,
                vendorId: model.products[index].vendorId,
              )
                  : AgentUpdate(
                description: model.products[index].description,
                houseId: model.products[index].id,
                image: model.products[index].image,
                title: model.products[index].title,
                edit: true,
                price: model.products[index].price,
                location: model.products[index].location,
                vendorId: model.products[index].vendorId,
              ),
            ),
          );
        },
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomViewPage(
              vendorId: model.products[index].vendorId,
              description: model.products[index].description,
              image: model.products[index].image,
              title: model.products[index].title,
              edit: model.products[index].vendorId ==
                  widget.models.authentication.id,
              houseId: model.products[index].id,
              location: model.products[index].location,
              price: model.products[index].price,
              type: model.products[index].type,
              isHouse: model.products[index].type == 'Foods&Drinks' ||
                  model.products[index].type == 'Properties&Goods'
                  ? false
                  : true,
              vendorName: model.products[index].vendorName,
              vendorNumber: model.products[index].vendorNumber,
            ),
          )),
    );
  }

  Widget _addItemInfo(int index, Models model) {
    return Column(
      children: [
        _buildListTile(index, model),
        Divider(),
      ],
    );
  }

  _listBuilder(Models model) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        return _addItemInfo(index, model);
      },
      itemCount: model.products.length,
    );
  }

  Text text(message) {
    return Text(
      message,
      style: TextStyle(color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Models>(
        builder: (context, child, Models model) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'My Uploads',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: widget.models.products.isEmpty
                ? Center(
              child: Text('No uploads yet'),
            )
                : _listBuilder(widget.models),
          );
        });
  }
}

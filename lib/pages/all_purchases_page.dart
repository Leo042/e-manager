import 'package:spot_manager/models/models.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/pages/room_view_page.dart';

class ViewAllPurchases extends StatefulWidget {
  final Models models;

  ViewAllPurchases({@required this.models});

  @override
  _ViewAllPurchasesState createState() => _ViewAllPurchasesState();
}

class _ViewAllPurchasesState extends State<ViewAllPurchases> {
  @override
  void initState() {
    widget.models.fetchAllPurchases();
    super.initState();
  }

  _buildListTile(int index, Models model) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(model.allPurchases[index].image),
      ),
      trailing: GestureDetector(
        onTap: () =>
            model.deleteMyPurchases(model.allPurchases[index].id, index),
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
      title: Text(
        model.allPurchases[index].title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: model.allPurchases[index].noOfOrder == null
          ? Text('')
          : Text(
              model.allPurchases[index].noOfOrder < 2
                  ? '${model.allPurchases[index].noOfOrder}' + ' order'
                  : '${model.allPurchases[index].noOfOrder}' + 'orders',
              style: TextStyle(fontWeight: FontWeight.w400)),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomViewPage(
              description: model.allPurchases[index].description,
              image: model.allPurchases[index].image,
              title: model.allPurchases[index].title,
              edit: model.allPurchases[index].vendorId ==
                  widget.models.authentication.id,
              houseId: model.allPurchases[index].id,
              location: model.allPurchases[index].location,
              price: model.allPurchases[index].price,
              type: model.allPurchases[index].type,
              isHouse: model.allPurchases[index].type == 'house',
              vendorId: model.allPurchases[index].vendorId,
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
      itemCount: model.allPurchases.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Models>(
        builder: (context, child, Models model) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'All Purchases',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: widget.models.allPurchases.isEmpty
              ? Center(
                  child: Text('No purchases yet'),
                )
              : _listBuilder(widget.models));
    });
  }
}

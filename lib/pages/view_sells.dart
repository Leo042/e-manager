import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/pages/room_view_page.dart';

class OrderPage extends StatefulWidget {
  final Models models;

  OrderPage({@required this.models});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    widget.models.authenticate();
  }

  _buildListTile(int index, Models model) {
    widget.models.authenticate();
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(model.orders[index].image),
      ),
      title: Text(
        model.orders[index].title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: model.orders[index].noOfOrder == null
          ? Text('')
          : Text(
              model.orders[index].noOfOrder < 2
                  ? '${model.orders[index].noOfOrder}' + ' order'
                  : '${model.orders[index].noOfOrder}' + 'orders',
              style: TextStyle(fontWeight: FontWeight.w400)),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomViewPage(
              description: model.orders[index].description,
              image: model.orders[index].image,
              title: model.orders[index].title,
              houseId: model.orders[index].id,
              location: model.orders[index].location,
              price: model.orders[index].price,
              type: model.orders[index].type,
              isHouse: model.orders[index].type == 'house',
              vendorName: model.orders[index].vendorName,
              vendorNumber: model.orders[index].vendorNumber,
              address: model.orders[index].address,
              noOfOrder: model.orders[index].noOfOrder,
              number: model.orders[index].number,
              amount: model.orders[index].subAmount,
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
      itemCount: model.orders.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Models>(
        builder: (context, child, Models model) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Sells',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: widget.models.orders.isEmpty
            ? Center(
                child: Text('No sells yet'),
              )
            : _listBuilder(widget.models),
      );
    });
  }
}

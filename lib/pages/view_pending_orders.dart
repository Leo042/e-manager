import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/pages/confirm_orders.dart';

class PendingOrders extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final Models model;

  PendingOrders({this.snapshot, @required this.model});

  _listBuilder() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManagersOrderPage(
                    models: model, myPendingOrder: snapshot.data.docs[index]['orderRef']),
              )),
          leading: Text(
            '${index + 1}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: SelectableText(
            snapshot.data.docs[index]['orderRef'],
            toolbarOptions: ToolbarOptions(
              copy: true,
              paste: false,
              cut: false,
              selectAll: true,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Orders'),
      ),
      body: snapshot.data.docs.isEmpty
          ? Center(
        child: Text('No Pending Order'),
      )
          : _listBuilder(),
    );
  }
}

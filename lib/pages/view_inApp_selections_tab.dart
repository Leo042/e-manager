import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/pages/view_categories.dart';

class SelectionTabView extends StatefulWidget {
  final String name;
  final String image;
  final int index;

  SelectionTabView({this.index, this.name, this.image});

  @override
  _SelectionTabViewState createState() => _SelectionTabViewState();
}

class _SelectionTabViewState extends State<SelectionTabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: widget.index,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'View Food Category',
              ),
              Tab(
                icon: Icon(Icons.select_all),
                text: 'View Goods Category',
              ),
              Tab(
                icon: Icon(Icons.house),
                text: 'View House Type',
              ),
              Tab(
                icon: Icon(Icons.location_on),
                text: 'View House Locations',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ScopedModelDescendant<Models>(
                builder: (context, child, Models model) {
              return ViewCategories(
                model: model,
                title: 'Food Categories',
                content: model.foodCategory,
                collectionName: null,
                function: model.getFoodCategory,
                index: 0,
              );
            }),
            ScopedModelDescendant<Models>(
                builder: (context, child, Models model) {
              return ViewCategories(
                model: model,
                title: 'Goods Categories',
                content: model.goodsCategory,
                collectionName: null,
                function: model.getGoodsCategory,
                index: 1,
              );
            }),
            ScopedModelDescendant<Models>(
                builder: (context, child, Models model) {
              return ViewCategories(
                model: model,
                title: 'House Type',
                content: model.houseType,
                collectionName: 'houseType',
                function: model.getAboutHouse,
                index: 2,
                noIcon: true,
              );
            }),
            ScopedModelDescendant<Models>(
                builder: (context, child, Models model) {
              return ViewCategories(
                model: model,
                title: 'House Location',
                content: model.houseLocation,
                collectionName: 'houseLocation',
                function: model.getAboutHouse,
                index: 3,
                noIcon: true,
              );
            }),
          ],
        ),
      ),
    );
  }
}

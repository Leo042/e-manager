import 'package:flutter/material.dart';
import 'package:spot_manager/inApp_selections/add_category.dart';

class SelectionTab extends StatefulWidget {
  final String name;
  final String image;
  final int index;

  SelectionTab({this.index, this.name, this.image});

  @override
  _SelectionTabState createState() => _SelectionTabState();
}

class _SelectionTabState extends State<SelectionTab> {
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
                  text: 'Add Food Category',
                ),
                Tab(
                  icon: Icon(Icons.select_all),
                  text: 'Add Goods Category',
                ),
                Tab(
                  icon: Icon(Icons.house),
                  text: 'Add House Type',
                ),
                Tab(
                  icon: Icon(Icons.location_on),
                  text: 'Add House Locations',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AddCategory(
                name: widget.name,
                image: widget.image,
                collectionName: 'food_category',
                buttonText: 'Add Icon',
                displayText: 'Food category icon will display here',
              ),
              AddCategory(
                image: widget.image,
                name: widget.name,
                collectionName: 'goods_category',
                buttonText: 'Add Icon',
                displayText: 'Goods category icon will display here',
              ),
              AddCategory(
                name: widget.name,
                collectionName: 'houseType',
                isHouseType: true,
                displayText: null,
                buttonText: null,
              ),
              AddCategory(
                name: widget.name,
                collectionName: 'houseLocations',
                isHouseLocation: true,
                buttonText: null,
                displayText: null,
              ),
            ],
          ),
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/add_owners_and_services/add_hotel_owners.dart';
import 'package:spot_manager/add_owners_and_services/create_services.dart';
import 'package:spot_manager/hotels/view_hotels.dart';
import 'package:spot_manager/inApp_selections/add_app_available_locations.dart';
import 'package:spot_manager/inApp_selections/selection_tab.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/pages/all_purchases_page.dart';
import 'package:spot_manager/pages/create_investment.dart';
import 'package:spot_manager/pages/view_bookings.dart';
import 'package:spot_manager/pages/view_categories.dart';
import 'package:spot_manager/pages/view_hotel_owners.dart';
import 'package:spot_manager/pages/view_inApp_selections_tab.dart';
import 'package:spot_manager/pages/view_pending_orders.dart';
import 'package:spot_manager/pages/view_post.dart';
import 'package:spot_manager/pages/view_sells.dart';

class MyHomePage extends StatefulWidget {
  final Models models;

  MyHomePage(this.models);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stream<QuerySnapshot> _stream;
  Stream<QuerySnapshot> stream;

  initState() {
    super.initState();
    widget.models.fetchMyPost();
    widget.models.fetchMySells();
    widget.models.fetchHotelOwners();
    widget.models.getGoodsCategory();
    widget.models.getFoodCategory();
    widget.models.getAboutHouse('houseType');
    widget.models.getAboutHouse('houseLocation');
    widget.models.fetchBookedRoom().then((value) {
      setState(() {
        _stream = value;
      });
    });
    widget.models.pendingOrders().then((value) {
      setState(() {
        stream = value;
      });
    });
  }

  GestureDetector material({@required String text, @required Widget page}) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          )),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepOrangeAccent,
        ),
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Material(
          color: Colors.deepOrangeAccent,
          elevation: 10,
          child: Center(
            child: Container(
                margin: EdgeInsets.all(8),
                child: Text(text)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ScopedModelDescendant<Models>(
          builder: (context, child, Models model) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      material(text: 'ADD HOTEL OWNERS', page: AddHotelOwner()),
                      material(text: 'ADD SERVICES', page: CreateService()),
                      material(
                          text: 'ADD CATEGORY/SELECTION',
                          page: SelectionTab(index: 0)),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      material(
                          text: 'ADD AVAILABLE LOCATIONS',
                          page: AddAvailableLocation('')),
                      material(text: 'ADD INVESTMENT', page: CreateInvestment()),
                      material(
                          text: 'VIEW HOTEL OWNERS', page: HotelOwnersPage(model)),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      material(text: 'VIEW ALL HOTELS', page: Hotels(model: model)),
                      material(
                          text: 'VIEW ALL PURCHASES',
                          page: ViewAllPurchases(models: model)),
                      StreamBuilder<QuerySnapshot>(
                          stream: stream,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            return material(
                                text: 'VIEW ALL PENDING ORDERS',
                                page: PendingOrders(
                                  model: model,
                                  snapshot: snapshot,
                                ));
                          }),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      material(
                          text: 'VIEW ALL POST', page: MyUploads(models: model)),
                      material(
                          text: 'VIEW ALL SELLS', page: OrderPage(models: model)),
                      StreamBuilder<QuerySnapshot>(
                          stream: _stream,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            return material(
                                text: 'VIEW ALL BOOKINGS',
                                page: MyBookingsList(
                                    snapshot: snapshot, model: model));
                          }),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      material(
                          text: 'VIEW CATEGORIES',
                          page: SelectionTabView(index: 0)),
                      material(
                          text: 'VIEW HOUSE TYPE',
                          page: SelectionTabView(index: 2)),
                      material(
                          text: 'VIEW HOUSE LOCATIONS',
                          page: SelectionTabView(index: 3)),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      material(
                          text: 'VIEW AVAILABLE LOCATIONS',
                          page: ViewAllAvailableLocations(
                            model: model,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

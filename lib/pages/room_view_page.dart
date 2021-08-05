import 'dart:convert';

import 'package:spot_manager/post_and_updates/agent_update.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/post_and_updates/update_goods_restaurants.dart';


class RoomViewPage extends StatelessWidget {
  final String image;
  final String roomNumber;
  final String title;
  final String description;
  final bool isSearch;
  final String noOfDays;
  final String checkIn;
  final String checkOut;
  final bool available;
  final String location;
  final String price;
  final bool edit;
  final String houseId;
  final String type;
  final bool isHouse;
  final String vendorId;
  final int noOfOrder;
  final String number;
  final String address;
  final String vendorName;
  final String vendorNumber;
  final String amount;
  final bool isHotel;
  final String collectionId;
  final String roomId;
  final bool searchRoom;
  final String hotelName;
  final int views;

  const RoomViewPage({
    this.image,
    this.isHotel,
    this.roomNumber,
    this.vendorId,
    @required this.isHouse,
    this.type,
    this.houseId,
    this.title,
    this.description,
    this.price,
    this.location,
    this.edit,
    this.noOfOrder,
    this.number,
    this.address,
    this.vendorName,
    this.vendorNumber,
    this.amount,
    this.collectionId,
    this.views,
    this.roomId,
    this.isSearch,
    this.noOfDays,
    this.checkIn,
    this.checkOut,
    this.available,
    this.searchRoom,
    this.hotelName,
  });

  Widget _listTile({
    String checkInDay,
    String checkInMonth,
    String checkInYear,
    String checkInHour,
    String checkInMinute,
    String text,
    String info,
    Color color,
    String checkInCheckOut,
    bool show,
  }) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      subtitle: checkInCheckOut != null && show == true
          ? Row(
        children: [
          Text(info),
          Column(
            children: [
              Text(' $checkInDay/$checkInMonth/$checkInYear'),
              Text(' $checkInHour:$checkInMinute')
            ],
          )
        ],
      )
          : Text(''),
    );
  }

  @override
  Widget build(BuildContext context) {
    var currency = utf8.decode([0xE2, 0x82, 0xA6]);
    DateTime _checkIn = checkIn.isEmpty? null: DateTime.tryParse(checkIn);
    DateTime _checkOut = checkOut.isEmpty? null: DateTime.tryParse(checkOut);
    bool showCheckIn = checkIn.isEmpty? null: _checkIn.isBefore(DateTime.now());
    bool showCheckOut = checkOut.isEmpty? null:_checkOut.isBefore(DateTime.now());
    String _checkInYear = checkIn.isEmpty? null: _checkIn.year.toString();
    String _checkOutYear = checkOut.isEmpty? null: _checkOut.year.toString();
    String _checkInMonth = checkIn.isEmpty? null: _checkIn.month.toString();
    String _checkOutMonth = checkOut.isEmpty? null: _checkOut.month.toString();
    String _checkInDay = checkIn.isEmpty? null: _checkIn.day.toString();
    String _checkOutDay = checkOut.isEmpty? null: _checkOut.day.toString();
    String _checkInHour = checkIn.isEmpty? null: _checkIn.hour.toString();
    String _checkOutHour = checkOut.isEmpty? null: _checkOut.hour.toString();
    String _checkInMinute = checkIn.isEmpty? null: _checkIn.minute.toString();
    String _checkOutMinute = checkOut.isEmpty? null: _checkOut.minute.toString();

    return ScopedModelDescendant<Models>(
        builder: (context, child, Models model) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  foregroundDecoration: BoxDecoration(color: Colors.black26),
                  height: 400,
                  width: double.infinity,
                  child: Center(
                    child: Image.network(image, fit: BoxFit.cover),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: 16, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 250),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: location == null
                            ? Text(
                          '$title\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            : Text(
                          '$title\n$location',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 16),
                          views != null || roomNumber != null
                              ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              roomNumber == null
                                  ? '$views views'
                                  : 'No $roomNumber',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13),
                            ),
                          )
                              : Container(),
                          Spacer(),
                          IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '$currency$price',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(
                              'DESCRIPTION',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('$description'),
                            SizedBox(height: 30),
                            isHouse == null
                                ? Container()
                                : SizedBox(
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: TextButton(
                                  child: isHotel == true
                                      ? Text('Book Room')
                                      : Text(
                                    isHouse == true
                                        ? 'Rent Now'
                                        : 'Add To Cart',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    // if (isHouse == true) {
                                    //   PaymentWidget
                                    //       .handlePaymentInitialization(
                                    //     number: model.authentication.number,
                                    //     name: model.authentication.fName,
                                    //     model: model,
                                    //     email: model.authentication.email,
                                    //     context: context,
                                    //     amount: price,
                                    //     isCart: false,
                                    //     agentId: vendorId,
                                    //     productId: houseId,
                                    //     agentName: vendorName,
                                    //     agentNumber: vendorNumber,
                                    //   );
                                    // }
                                    // if (isHotel == true) {
                                    //   return Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             BookRoomDetails(
                                    //               roomNumber: roomNumber,
                                    //               hotelName: hotelName,
                                    //               collectionId: collectionId,
                                    //               roomId: roomId,
                                    //               price: price,
                                    //               checkOut: _checkOut,
                                    //               checkIn: _checkIn,
                                    //             ),
                                    //       ));
                                    // } else {
                                    //   model.addToCartORFavourites(
                                    //     type,
                                    //     houseId,
                                    //     model.authentication.id,
                                    //     'carts',
                                    //     vendorName,
                                    //     vendorNumber,
                                    //     title,
                                    //     price,
                                    //   );
                                    // }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      available == true
                          ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: _listTile(
                            checkInYear: _checkInYear,
                            checkInMonth: _checkInMonth,
                            checkInMinute: _checkInMinute,
                            checkInHour: _checkInHour,
                            checkInDay: _checkInDay,
                            checkInCheckOut: checkIn,
                            info: 'Available Till',
                            show: showCheckIn,
                            color: Colors.green,
                            text: 'Room Available!'),
                      )
                          : Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: _listTile(
                          text: 'Room Not Available!',
                          info: 'Not Available till',
                          show: showCheckOut,
                          checkInCheckOut: checkOut,
                          color: Colors.red,
                          checkInDay: _checkOutDay,
                          checkInHour: _checkOutHour,
                          checkInMinute: _checkOutMinute,
                          checkInMonth: _checkOutMonth,
                          checkInYear: _checkOutYear,
                        ),
                      ),
                      (
                          // model.authentication.number == vendorNumber &&
                          isHotel != true) ||
                          isSearch == true
                          ? OrderInfo(
                        model: model,
                        vendorName: vendorName,
                        vendorNumber: vendorNumber,
                        address: address,
                        noOfOrder: noOfOrder,
                        amount: amount,
                        noOfDays: noOfDays,
                        checkIn: checkIn,
                        checkOut: checkOut,
                        price: price,
                        isSearch: isSearch,
                        searchRoom: searchRoom,
                        number: number,
                      )
                          : Container(),
                    ],
                  ),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  actions: [
                    edit == true
                        ? IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                location == null || location.isEmpty
                                // type == 'Self-Con' ||
                                //         type == 'One-Room' ||
                                //         type == 'Apartment'
                                    ? UpdateGoodsRestaurant(
                                  title: title,
                                  edit: edit,
                                  price: price,
                                  description: description,
                                  image: image,
                                  houseId: houseId,
                                  type: type,
                                  vendorId: vendorId,
                                )
                                    : AgentUpdate(
                                  houseId: houseId,
                                  edit: edit,
                                  title: title,
                                  image: image,
                                  description: description,
                                  location: location,
                                  price: price,
                                ))),
                        icon: Icon(Icons.edit))
                        : Container()
                  ],
                  title: Text(
                    'DETAILS',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class OrderInfo extends StatelessWidget {
  final Models model;
  final String number;
  final String address;
  final int noOfOrder;
  final String vendorNumber;
  final String vendorName;
  final String amount;
  final String noOfDays;
  final String checkIn;
  final String checkOut;
  final bool searchRoom;
  final bool isSearch;
  final String price;

  OrderInfo({
    this.model,
    this.number,
    this.address,
    this.noOfOrder,
    this.vendorNumber,
    this.vendorName,
    this.amount,
    this.noOfDays,
    this.checkIn,
    this.checkOut,
    this.isSearch,
    this.price,
    this.searchRoom,
  });

  Widget bookDetails({
    String checkInYear,
    String checkOutYear,
    String checkInMonth,
    String checkOutMonth,
    String checkInDay,
    String checkOutDay,
    String checkInHour,
    String checkOutHour,
    String checkInMinute,
    String checkOutMinute,
    bool expired,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          leading: Icon(Icons.timer),
          title: Text('Check-In Date:'),
          subtitle: Text(
              '$checkInDay/$checkInMonth/$checkInYear\nTime: $checkInHour:$checkInMinute'),
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          leading: Icon(Icons.timer_off),
          title: Text('Check-Out Date:'),
          subtitle: Text(
              '$checkOutDay/$checkOutMonth/$checkOutYear\nTime: $checkOutHour:$checkOutMinute'),
        ),
        SizedBox(height: 10),
        expired == true
            ? Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10),
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Text(
              'EXPIRED',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime _checkIn = DateTime.tryParse(checkIn);
    DateTime _checkOut = DateTime.tryParse(checkOut);
    String _checkInYear = _checkIn.year.toString();
    String _checkOutYear = _checkOut.year.toString();
    String _checkInMonth = _checkIn.month.toString();
    String _checkOutMonth = _checkOut.month.toString();
    String _checkInDay = _checkIn.day.toString();
    String _checkOutDay = _checkOut.day.toString();
    String _checkInHour = _checkIn.hour.toString();
    String _checkOutHour = _checkOut.hour.toString();
    String _checkInMinute = _checkIn.minute.toString();
    String _checkOutMinute = _checkOut.minute.toString();
    bool _expired = DateTime.tryParse(checkOut).isAfter(DateTime.now());

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      isSearch == true ? 'Booking Details' : 'Order Details',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Divider(
                    color: Colors.black38,
                  ),
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          leading: Icon(Icons.confirmation_number_outlined),
                          title: Text(isSearch == true
                              ? 'No Of Days:'
                              : 'Quantity Of Order:'),
                          subtitle: isSearch == true
                              ? Text('$noOfDays')
                              : Text('$noOfOrder'),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          leading: Icon(Icons.money),
                          title: Text(isSearch == true ? 'Price:' : 'Amount:'),
                          subtitle: isSearch == true
                              ? Text('$price')
                              : Text('$amount'),
                        ),
                        isSearch == true
                            ? bookDetails(
                          checkInDay: _checkInDay,
                          checkInHour: _checkInHour,
                          checkInMinute: _checkInMinute,
                          checkInMonth: _checkInMonth,
                          checkInYear: _checkInYear,
                          checkOutDay: _checkOutDay,
                          checkOutHour: _checkOutHour,
                          checkOutMinute: _checkOutMinute,
                          checkOutMonth: _checkOutMonth,
                          checkOutYear: _checkOutYear,
                          expired: _expired,
                        )
                            : Container(),
                        // model.myHotels.isNotEmpty &&
                            isSearch != true &&
                            searchRoom != true
                            ? Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              leading: Icon(Icons.my_location),
                              title: Text('Recipient Address:'),
                              subtitle: address == null
                                  ? Text('')
                                  : SelectableText(
                                address,
                                toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false,
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              leading: Icon(Icons.phone),
                              title: Text('Recipient Number:'),
                              subtitle: number == null
                                  ? Text('')
                                  : SelectableText(
                                number,
                                toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false,
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              leading: Icon(Icons.person),
                              title: Text('Agent/Vendor Name:'),
                              subtitle: vendorName == null
                                  ? Text('')
                                  : SelectableText(
                                vendorName,
                                toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false,
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              leading: Icon(Icons.my_location),
                              title: Text('Agent/Vendor Number:'),
                              subtitle: vendorNumber == null
                                  ? Text('')
                                  : SelectableText(
                                vendorNumber,
                                toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false,
                                ),
                              ),
                            ),
                          ],
                        )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spot_manager/models/models.dart';

class MyBookingDetails extends StatelessWidget {
  final String checkIn;
  final String checkOut;
  final String price;
  final String noOfDays;
  final String bookRef;
  final String hotelName;
  final String roomNumber;
  final String collectionId;
  final Models model;
  final String id;
  final Function deleteFunction;

  MyBookingDetails({
    this.checkOut,
    this.checkIn,
    this.price,
    this.noOfDays,
    this.bookRef,
    this.hotelName,
    this.roomNumber,
    this.collectionId,
    this.model,
    this.id,
    this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Material(
              elevation: 10,
              shadowColor: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
              child: ListTile(
                title: Text(
                  'NOTE:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: Text(
                  "Don't share your booking code with anyone!",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BookingInfo(
                      checkIn: checkIn,
                      checkOut: checkOut,
                      price: price,
                      noOfDays: noOfDays,
                      hotelName: hotelName,
                      roomNumber: roomNumber,
                      bookRef: bookRef,
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                // deleteFunction(context, model, id, collectionId);
                // Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: Text(
                  'DELETE',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingInfo extends StatelessWidget {
  final String noOfDays;
  final String checkIn;
  final String checkOut;
  final String price;
  final String bookRef;
  final String hotelName;
  final String roomNumber;

  BookingInfo({
    this.noOfDays,
    this.checkIn,
    this.checkOut,
    this.price,
    this.bookRef,
    this.hotelName,
    this.roomNumber,
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
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Booking Details',
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
                          leading: Icon(Icons.hotel),
                          subtitle: Text('$hotelName'),
                          title: Text('Hotel Name:'),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          leading: Icon(Icons.room_preferences),
                          subtitle: Text('$roomNumber'),
                          title: Text('Room Number:'),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          leading: Icon(Icons.confirmation_number),
                          subtitle: Text('$bookRef'),
                          title: Text('Booking Code:'),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          leading: Icon(Icons.confirmation_number_outlined),
                          subtitle: Text('$noOfDays'),
                          title: Text('No Of Days:'),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          leading: Icon(Icons.money),
                          title: Text('Price:'),
                          subtitle: Text('$price'),
                        ),
                        bookDetails(
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
                        ),
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

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

class SendPushNotifications {
  static final postUrl = 'https://api.rnfirebase.io/messaging/send';

  static Future<bool> sendNotifications(token, msg) async {
    final data = {
      'token': token,
      'data': {
        'chatRoomId': '${msg['chatRoomId']}',
        'senderId': '${msg['senderId']}',
      },
      'notification': {
        'title': '${msg['uname']}',
        'body': '${msg['message']}',
      },
    };

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      http.Response response = await http.post(Uri.parse(postUrl),
          body: json.encode(data), headers: headers);

      print(json.decode(response.body));
      print('Push Notification Success');
      return true;
    } on HttpException catch (e) {
      print('push error= ${e.message}');
      return false;
    }
  }

  static Future<bool> sendOrdersNotifications(token, msg) async {
    final data = {
      'token': token,
      'data': {
        'name': '${msg['name']}',
        'number': '${msg['number']}',
        'address': '${msg['address']}',
      },
      'notification': {
        'title': '${msg['uname']}',
        'body': '${msg['message']}',
      },
    };

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      http.Response response = await http.post(Uri.parse(postUrl),
          body: json.encode(data), headers: headers);

      print(json.decode(response.body));
      print('Push Notification Success');
      return true;
    } on HttpException catch (e) {
      print('push error= ${e.message}');
      return false;
    }
  }

  static Future<bool> sendHouseNotifications(token, msg) async {
    final data = {
      'token': token,
      'data': {
        'name': '${msg['name']}',
        'number': '${msg['number']}',
      },
      'notification': {
        'title': '${msg['uname']}',
        'body': '${msg['message']}',
      },
    };

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      http.Response response = await http.post(Uri.parse(postUrl),
          body: json.encode(data), headers: headers);

      print(json.decode(response.body));
      print('Push Notification Success');
      return true;
    } on HttpException catch (e) {
      print('push error= ${e.message}');
      return false;
    }
  }
}

class Users {
  final String id;
  final String email;
  final dynamic password;

  Users({
    @required this.id,
    @required this.email,
    this.password,
  });
}

class AllPurchases {
  final String image;
  final String description;
  final String location;
  final String price;
  final String title;
  final String id;
  final String vendorId;
  final String type;
  final int noOfOrder;
  final int subAmount;

  AllPurchases({
    this.image,
    this.description,
    this.location,
    this.price,
    this.title,
    this.id,
    @required this.vendorId,
    this.type,
    this.noOfOrder,
    this.subAmount,
  });
}

class ChatUsers {
  final String userId;
  final String chatRoomId;
  final String email;
  final String userName;
  final String number;
  final String profileImage;
  final String lastMessage;

  ChatUsers(
      {@required this.userId,
      @required this.chatRoomId,
      @required this.email,
      @required this.userName,
      this.number,
      this.profileImage,
      this.lastMessage});
}

class HotelOwners {
  final String logo;
  final String name;
  final String ownerName;
  final String ownerNumber;
  final String location;
  final String area;
  final String id;
  final String collectionId;

  HotelOwners(
      {this.name,
      this.id,
      this.collectionId,
      this.area,
      this.ownerName,
      this.ownerNumber,
      this.location,
      this.logo});
}

class HotelRooms {
  final String image;
  final String roomNumber;
  final String noOfDays;
  final String checkIn;
  final String checkOut;
  final bool available;
  final String title;
  final String price;
  final String details;

  HotelRooms(
      {this.image,
      this.price,
      this.details,
      this.title,
      this.roomNumber,
      this.noOfDays,
      this.checkIn,
      this.checkOut,
      this.available});
}

class MyHotels {
  final String hotelName;
  final String hotelLogo;
  final String hotelId;
  final String hotelLocation;
  final String hotelArea;
  final String collectionId;

  MyHotels(
      {this.hotelId,
      this.hotelLogo,
      this.hotelName,
      this.collectionId,
      this.hotelLocation,
      this.hotelArea});
}

class Products {
  final String image;
  final String description;
  final String location;
  final String price;
  final String title;
  final String id;
  final String vendorId;
  final String type;
  final int noOfOrder;
  final int views;
  final String vendorName;
  final String vendorNumber;

  Products({
    this.vendorName,
    this.vendorNumber,
    this.image,
    this.description,
    this.location,
    this.price,
    this.title,
    this.views,
    this.id,
    @required this.vendorId,
    this.type,
    this.noOfOrder,
  });
}

class Orders {
  final String image;
  final String description;
  final String location;
  final String price;
  final String title;
  final String id;
  final String type;
  final int noOfOrder;
  final String subAmount;
  final String number;
  final String address;
  final String vendorName;
  final String vendorNumber;

  Orders({
    this.vendorName,
    this.vendorNumber,
    this.image,
    this.number,
    this.address,
    this.description,
    this.location,
    this.price,
    this.title,
    this.id,
    this.type,
    this.noOfOrder,
    this.subAmount,
  });
}

class FoodCategory {
  final String icon;
  final String title;
  final String id;

  FoodCategory({@required this.icon, @required this.id, @required this.title});
}

class GoodsCategory {
  final String icon;
  final String title;
  final String id;

  GoodsCategory({@required this.icon, @required this.id, @required this.title});
}

class AvailableLocations {
  final String area;
  final String id;

  AvailableLocations({@required this.area, @required this.id});
}

class HouseType {
  final String title;
  final String id;

  HouseType({@required this.title, @required this.id});
}

class HouseLocation {
  final String title;
  final String id;

  HouseLocation({@required this.title, @required this.id});
}

class Models extends Model {
  Users _authentication;
  bool _isLoading;
  String _profileImagePath;
  String _profileImageUrl;
  List<AllPurchases> _allPurchases = [];
  List<ChatUsers> _chatUsers = [];
  List<MyHotels> _myHotels = [];
  List<HotelOwners> _hotelOwners = [];
  List<HotelRooms> _hotelRooms = [];
  List<Products> _products = [];
  List<Orders> _orders = [];
  List<FoodCategory> _foodCategory = [];
  List<GoodsCategory> _goodsCategory = [];
  List<HouseType> _houseType = [];
  List<HouseLocation> _houseLocation = [];
  List<AvailableLocations> _availableLocations = [];
  int _totalSells = 0;
  double _totalSellsAmount = 0;

  List<FoodCategory> get foodCategory {
    return List.from(_foodCategory);
  }

  List<AvailableLocations> get availableLocations {
    return List.from(_availableLocations);
  }

  List<HouseType> get houseType {
    return List.from(_houseType);
  }

  List<HouseLocation> get houseLocation {
    return List.from(_houseLocation);
  }

  List<GoodsCategory> get goodsCategory {
    return List.from(_goodsCategory);
  }

  List<HotelOwners> get hotelsOwners {
    return _hotelOwners;
  }

  List<HotelRooms> get hotelRooms {
    return List.from(_hotelRooms);
  }

  Users get authentication {
    return _authentication;
  }

  List<MyHotels> get myHotels {
    return List.from(_myHotels);
  }

  List<ChatUsers> get chatUsers {
    return List.from(_chatUsers);
  }

  List<AllPurchases> get allPurchases {
    return List.from(_allPurchases);
  }

  List<Products> get products {
    return List.from(_products);
  }

  List<Orders> get orders {
    return List.from(_orders);
  }

  int get totalSells {
    return _totalSells;
  }

  double get totalSellsAmount {
    return _totalSellsAmount;
  }

  bool get isLoading {
    return _isLoading;
  }

  bool _choose;

  bool get choose {
    return _choose;
  }

  bool _chooseImage;
  bool _chooseSelected;
  bool _chooseType;
  bool _chooseFoodCategory;
  bool _chooseGoodsCategory;
  bool _typeSelected;
  bool _foodCategorySelected;
  bool _goodsCategorySelected;
  bool _chooseLocation;
  bool _locationSelected;
  bool _imageNeeded;

  chooseNeeded(bool choose) {
    _choose = choose;
    notifyListeners();
  }

  selectImage(bool select) {
    _chooseImage = select;
    notifyListeners();
  }

  typeNeeded(bool choose) {
    _chooseType = choose;
    notifyListeners();
  }

  locationNeeded(bool choose) {
    _chooseLocation = choose;
    notifyListeners();
  }

  bool get typeSelected {
    return _typeSelected;
  }

  bool get chooseImage {
    return _chooseImage;
  }

  bool get locationSelected {
    return _locationSelected;
  }

  selectLocation(bool select) {
    _locationSelected = select;
    notifyListeners();
  }

  foodCategoryNeeded(bool choose) {
    _chooseFoodCategory = choose;
    notifyListeners();
  }

  goodsCategoryNeeded(bool choose) {
    _chooseGoodsCategory = choose;
    notifyListeners();
  }

  selectType(bool select) {
    _typeSelected = select;
    notifyListeners();
  }

  selectFoodCategory(bool select) {
    _foodCategorySelected = select;
    notifyListeners();
  }

  selectGoodsCategory(bool select) {
    _goodsCategorySelected = select;
    notifyListeners();
  }

  neededImage(bool select) {
    _imageNeeded = select;
    notifyListeners();
  }

  bool get postUploading {
    return _postUploadingError;
  }

  String get postUploadErrorMessage {
    return _postUploadErrorMessage;
  }

  bool _postUploadingError;
  String _postUploadErrorMessage;
  File _image;

  bool get imageNeeded {
    return _imageNeeded;
  }

  bool get chooseType {
    return _chooseType;
  }

  bool get chooseFoodCategory {
    return _chooseFoodCategory;
  }

  bool get chooseGoodsCategory {
    return _chooseGoodsCategory;
  }

  bool get chooseLocation {
    return _chooseLocation;
  }

  bool get chooseSelected {
    return _chooseSelected;
  }

  bool get foodCategorySelected {
    return _foodCategorySelected;
  }

  bool get goodsCategorySelected {
    return _goodsCategorySelected;
  }

  selectChoose(bool select) {
    _chooseSelected = select;
    notifyListeners();
  }

  setImage(File image, bool select) {
    _image = image;
    notifyListeners();
    _chooseImage = select;
    notifyListeners();
  }

  File get image {
    return _image;
  }

  fetchMySells() async {
    List _fetchOrders = [];
    List _addTotalSells = [];
    List _addTotalSellsAmount = [];
    CollectionReference reference =
        FirebaseFirestore.instance.collection('purchases');
    reference.doc().collection('myPurchases').snapshots().forEach((element) {
      element.docs.forEach((element) {
        String collectionPath = element.data()['type'];
        String productId = element.data()['productId'];
        int noOfOrder = element.data()['noOfOrder'];
        String vendorNumber = element.data()['vendorNumber'];
        String vendorName = element.data()['vendorName'];
        String number = element.data()['number'];
        String address = element.data()['address'];
        notifyListeners();
        return FirebaseFirestore.instance
            .collection(collectionPath)
            .doc(productId)
            .snapshots()
            .forEach((element) async {
          final _uploadedToPurchases = Orders(
              description: element.data()['description'],
              id: element.id,
              image: element.data()['image'],
              type: element.data()['type'],
              location: element.data()['location'],
              price: element.data()['price'],
              title: element.data()['title'],
              noOfOrder: noOfOrder,
              number: number,
              address: address,
              vendorName: vendorName,
              vendorNumber: vendorNumber,
              subAmount:
                  (noOfOrder * double.tryParse(element.data()['price']) * 0.1)
                      .toString());
          _fetchOrders.add(_uploadedToPurchases);
          _orders = _fetchOrders;
          notifyListeners();
        });
      });
      _orders.forEach((element) {
        _addTotalSells.add(element.noOfOrder);
        _addTotalSellsAmount
            .add((element.noOfOrder * double.tryParse(element.price) * 0.1));
      });
      notifyListeners();
      if (_addTotalSells.isNotEmpty) {
        _totalSells = _addTotalSells.reduce((a, b) => a + b);
        _totalSellsAmount = _addTotalSellsAmount.reduce((a, b) => a + b);
        notifyListeners();
      }
    });
  }

  Future<dynamic> fetchMyPost() async {
    final List<Products> fetchedProducts = [];
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('users');
      await reference
          .doc()
          .collection('myPost')
          .snapshots()
          .forEach((element) async {
        element.docs.forEach((element) async {
          String collectionPath = element.data()['type'];
          String productId = element.data()['productId'];
          String vendorId = element.data()['vendorId'];
          return FirebaseFirestore.instance
              .collection(collectionPath)
              .doc(productId)
              .snapshots()
              .forEach((element) {
            if (element.exists) {
              final _uploadedProducts = Products(
                description: element.data()['description'],
                id: element.id,
                vendorId: vendorId,
                image: element.data()['image'],
                type: element.data()['type'],
                location: element.data()['location'],
                price: '${element.data()['price']}',
                title: element.data()['title'],
                vendorName: element.data()['vendorName'],
                vendorNumber: element.data()['vendorNumber'],
              );
              fetchedProducts.add(_uploadedProducts);
              _products = fetchedProducts;
              notifyListeners();
            }
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> updateHouse(
    File image,
    String type,
    String location,
    String description,
    String price,
    bool update,
    String id,
  ) async {
    _postUploadingError = true;
    notifyListeners();
    try {
      if (update == true) {
        if (image != null) {
          await upLoadPicture(image, 'lodgeImage');
          String _description = description;
          int _price = int.tryParse(price.replaceAll(',', '').trim());
          Map<String, dynamic> lodge = {
            'image': _profileImageUrl,
            'description': _description,
            'price': '$_price',
            'userId': _authentication.id,
          };
          CollectionReference reference =
              FirebaseFirestore.instance.collection('house');
          await reference.doc(id).update(lodge);
        } else {
          String _description = description;
          String _price = price;
          Map<String, dynamic> _lodge = {
            'description': _description,
            'price': '$_price',
          };
          CollectionReference reference =
              FirebaseFirestore.instance.collection('house');
          await reference.doc(id).update(_lodge);
        }
        _postUploadingError = false;
        _postUploadErrorMessage = 'Update Successful';
        notifyListeners();
      } else {
        await upLoadPicture(image, 'lodgeImage');
        int _price = int.tryParse(price.replaceAll(',', '').trim());
        Map<String, dynamic> lodge = {
          'title': type,
          'image': _profileImageUrl,
          'location': location,
          'description': description,
          'price': '$_price',
          'vendorId': _authentication.id,
          'vendorName': 'manger',
          'vendorNumber': '',
          'favourites': [],
          'views': 0,
        };
        CollectionReference reference =
            FirebaseFirestore.instance.collection('house');
        await reference.add(lodge).then((element) {
          element.get().then((element) async {
            Map<String, dynamic> myPost = {
              'vendorId': _authentication.id,
              'type': 'house',
              'productId': element.id,
            };
            CollectionReference reference =
                FirebaseFirestore.instance.collection('users');
            reference.doc(_authentication.id).collection('myPost').add(myPost);
          });
        });
        _postUploadingError = false;
        _postUploadErrorMessage = 'Upload Successful';
        notifyListeners();
      }
      return {
        'success': _postUploadErrorMessage,
      };
    } catch (error) {
      print(error);
      _postUploadingError = false;
      _postUploadErrorMessage =
          'Upload failed! Check your internet connection and try again';
      notifyListeners();
    }
    return {
      'success': _postUploadErrorMessage,
    };
  }

  Future<Map<String, dynamic>> updateSells(
    File image,
    String title,
    String description,
    String price,
    String type,
    String id,
    bool update,
    String initialDescription,
    String initialPrice,
    String initialTitle,
    String goodsCategory,
    String foodCategory,
  ) async {
    _postUploadingError = true;
    notifyListeners();
    try {
      if (update == true) {
        if (image != null) {
          await upLoadPicture(image, '${type + 'Image'}');
          String _title = title == null ? initialTitle : title;
          String _description =
              description == null ? initialDescription : description;
          String _price = price == null ? initialPrice : price;
          Map<String, dynamic> goods = {
            'title': _title,
            'image': _profileImageUrl,
            'description': _description,
            'price': _price,
          };
          CollectionReference reference =
              FirebaseFirestore.instance.collection('$type');

          reference.doc(id).update(goods);
          _postUploadingError = false;
          _postUploadErrorMessage = 'Update was successful';
          notifyListeners();
          return {
            'uploadError': _postUploadingError,
            'success': _postUploadErrorMessage
          };
        } else {
          String _title = title == null ? initialTitle : title;
          String _description =
              description == null ? initialDescription : description;
          String _price = price == null ? initialPrice : price;
          Map<String, dynamic> _goods = {
            'title': _title,
            'description': _description,
            'price': _price,
          };
          CollectionReference reference =
              FirebaseFirestore.instance.collection('$type');
          await reference.doc(id).update(_goods);
          _postUploadingError = false;
          _postUploadErrorMessage = 'Update was successful';
          notifyListeners();
          return {
            'uploadError': _postUploadingError,
            'success': _postUploadErrorMessage
          };
        }
      } else {
        await upLoadPicture(image, '${type + 'Image'}');
        String category = type == 'Foods&Drinks' ? foodCategory : goodsCategory;
        Map<String, dynamic> goods = {
          'title': title,
          'type': type,
          'views': 0,
          'image': _profileImageUrl,
          'description': description,
          'price': price,
          'category': category,
          'vendorId': _authentication.id,
          'vendorName': 'manager',
          'vendorNumber': '',
          'favourites': [],
        };
        CollectionReference reference =
            FirebaseFirestore.instance.collection('$type');
        await reference.add(goods).then((element) {
          element.get().then((element) async {
            Map<String, dynamic> myPost = {
              'vendorId': _authentication.id,
              'type': element['type'],
              'productId': element.id,
            };
            CollectionReference reference = FirebaseFirestore.instance
                .collection('users')
                .doc(_authentication.id)
                .collection('myPost');

            reference.add(myPost);
          });
        });
      }
      _postUploadingError = false;
      _postUploadErrorMessage = 'Upload was successful';
      notifyListeners();
      return {
        'uploadError': _postUploadingError,
        'success': _postUploadErrorMessage
      };
    } catch (error) {
      print(error);
      _postUploadingError = false;
      _postUploadErrorMessage =
          'Upload failed! Check your internet connection and try again';
      notifyListeners();
      return {
        'uploadError': _postUploadingError,
        'success': _postUploadErrorMessage
      };
    }
  }

  deleteMyPurchases(String id, int index) async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection('purchases');
    ref
        .doc(_authentication.id)
        .collection('myPurchases')
        .doc(id)
        .update({'deleted': true});
    _allPurchases.removeAt(index);
    notifyListeners();
  }

  setChatImage(File image, String chatId) async {
    File chatImage = image;
    notifyListeners();
    if (image != null) {
      await upLoadPicture(chatImage, 'chatImages');
    }

    Map<String, dynamic> messageMap = {
      'chatImagePath': _profileImagePath,
      'chatImageUrl': _profileImageUrl,
      'sender': _authentication.id,
      'time': DateTime.now().millisecondsSinceEpoch,
    };
    CollectionReference users =
        FirebaseFirestore.instance.collection('chatRoom');
    return users
        .doc(chatId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print('message error= ' + e);
      chatImage = null;
      _profileImageUrl = null;
      _profileImagePath = null;
      notifyListeners();
    });
  }

//Function for manager
  Future<Map<String, dynamic>> createFoodCategory(
      {File image, String name, String category}) async {
    _isLoading = true;
    String title = 'ERROR';
    String message = 'Problem occurred. Try again later';
    notifyListeners();
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection(category);
      if (image != null) {
        await upLoadPicture(image, category);
      }
      Map<String, dynamic> map = {
        image == null ? null : 'image': _profileImageUrl,
        'name': name,
      };
      await ref.add(map);
      _profileImageUrl = null;
      _image = null;
      _isLoading = false;
      message = 'Was added successfully';
      title = 'SUCCESSFUL';
      notifyListeners();
      return {'message': message, 'title': title};
    } on FirebaseException catch (e) {
      _isLoading = false;
      print(e.code);
      return {'message': message, 'title': title};
    }
  }

  List<DropdownMenuItem<String>> getFoodCategoryList = [];

  getFoodCategory() async {
    List fetchedCategory = [];
    CollectionReference ref =
        FirebaseFirestore.instance.collection('food_category');
    await ref.snapshots().forEach((element) {
      element.docs.forEach((element) {
        final cate = FoodCategory(
            icon: element['image'], title: element['name'], id: element.id);
        fetchedCategory.add(cate);
        _foodCategory = fetchedCategory;
        getFoodCategoryList.add(element['name']);
        notifyListeners();
      });
    });
  }

  List<DropdownMenuItem<String>> getGoodsCategoryList = [];

  getGoodsCategory() async {
    List fetchedCategory = [];
    CollectionReference ref =
        FirebaseFirestore.instance.collection('goods_category');
    await ref.snapshots().forEach((element) {
      element.docs.forEach((element) {
        final cate = GoodsCategory(
            icon: element['image'], title: element['name'], id: element.id);
        fetchedCategory.add(cate);
        _goodsCategory = fetchedCategory;
        getGoodsCategoryList.add(element['name']);
        notifyListeners();
      });
    });
  }

  List<DropdownMenuItem<String>> getHouseType = [];
  List<DropdownMenuItem<String>> getHouseLocation = [];

  getAboutHouse(String collectionName) async {
    List fetchedCategory = [];
    CollectionReference ref =
        FirebaseFirestore.instance.collection(collectionName);
    await ref.snapshots().forEach((element) {
      element.docs.forEach((element) {
        final cate = collectionName == 'houseType'
            ? HouseType(title: element['name'], id: element.id)
            : HouseLocation(title: element['name'], id: element.id);
        fetchedCategory.add(cate);
        collectionName == 'houseType'
            ? _houseType = fetchedCategory
            : _houseLocation = fetchedCategory;
        collectionName == 'houseType'
            ? getHouseType.add(element['name'])
            : getHouseLocation.add(element['name']);
        notifyListeners();
      });
    });
  }

  // Function for developer
  Future<Map<String, dynamic>> addAvailableLocations(String location) async {
    _isLoading = true;
    String message =
        'Problem occurred. Check your internet connection and try again later';
    String title = 'ERROR';
    notifyListeners();
    try {
      String _location = location.toLowerCase();
      CollectionReference ref =
          FirebaseFirestore.instance.collection('available_Locations');
      await ref.add({'area': _location});
      _isLoading = false;
      message = 'Location was added successfully';
      notifyListeners();
      return {'message': message, 'title': title};
    } on FirebaseException catch (e) {
      _isLoading = false;
      print(e.code);
      return {'message': message, 'title': title};
    }
  }

  getAvailableLocations() async {
    List fetchedLocations = [];
    CollectionReference ref =
        FirebaseFirestore.instance.collection('available_Locations');
    await ref.snapshots().forEach((element) {
      element.docs.forEach((element) {
        final locations =
            AvailableLocations(area: element['area'], id: element.id);
        fetchedLocations.add(locations);
        _availableLocations = fetchedLocations;
        notifyListeners();
      });
    });
  }

  //Function for developer
  Future<Map<String, dynamic>> canInvest(
      bool choose, int percentage, int noOfMonths, String terms) async {
    _isLoading = true;
    String message =
        'Problem occurred. Check your internet connection and try again';
    String title = 'ERROR';
    notifyListeners();
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('canInvest');
      await ref.add({
        'makeInvestment': choose,
        'percentage': percentage,
        'noOfMonths': noOfMonths,
        'terms': terms,
      });
      _isLoading = false;
      message = 'Was added successfully';
      title = 'SUCCESSFUL';
      notifyListeners();
      return {'message': message, 'title': title};
    } on FirebaseException catch (e) {
      print(e.code);
      return {'message': message, 'title': title};
    }
  }

  // ignore: missing_return
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> fetchHotels(
      [String ownerNumber]) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('hotels');
    if (ownerNumber == null) {
      return ref.doc().collection('hotel').snapshots();
    } else {
      List fetchedHotel = [];
      await ref
          .doc()
          .collection('owner')
          .where('number', isEqualTo: ownerNumber)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          final collectionId = element.data()['collectionId'];
          if (value.docs.length < 1 ||
              value.docs.isEmpty ||
              collectionId.isEmpty) {
            return;
          } else {
            ref.doc(collectionId).collection('hotel').get().then((value) {
              value.docs.forEach((element) {
                final _hotel = MyHotels(
                  collectionId: element.data()['collectionId'],
                  hotelId: element.data()['hotelId'],
                  hotelLogo: element.data()['logo'],
                  hotelName: element.data()['name'],
                  hotelLocation: element.data()['location'],
                  hotelArea: element.data()['area'],
                );
                fetchedHotel.add(_hotel);
                _myHotels = fetchedHotel;
                notifyListeners();
              });
            });
          }
        });
      });
    }
  }

//Function for developer
  Future<Map<String, dynamic>> addHotelOwner(
      File logo,
      String name,
      String ownerName,
      String ownerNumber,
      String location,
      String area,
      String collectionId,
      String id,
      String editLogo,
      [bool edit]) async {
    _isLoading = true;
    String errorMessage = 'ERROR';
    String message =
        'Problem occurred. Check your internet connection and try again';
    notifyListeners();
    try {
      if (logo != null) {
        await upLoadPicture(logo, 'hotelOwners');
      }
      String image = logo == null ? editLogo : _profileImageUrl;
      if (edit == true) {
        CollectionReference ref = FirebaseFirestore.instance
            .collection('hotels')
            .doc(collectionId)
            .collection('owner');
        CollectionReference collectionReference = FirebaseFirestore.instance
            .collection('hotels')
            .doc(collectionId)
            .collection('hotel');
        await ref.doc(id).update({
          'name': ownerName,
          'number': ownerNumber,
        }).then((value) async {
          QuerySnapshot<Object> hotelId =
              await collectionReference.where('name', isEqualTo: name).get();
          hotelId.docs.forEach((element) {
            collectionReference.doc(element.id).update({
              'name': name,
              'logo': image,
              'location': location,
              'area': area,
            });
          });
        });
        _isLoading = false;
        message = 'Owner was added';
        errorMessage = 'SUCCESSFUL';
        notifyListeners();
        return {'message': message};
      } else {
        DocumentReference<Map<String, dynamic>> ref =
            FirebaseFirestore.instance.collection('hotels').doc();
        CollectionReference reference = ref.collection('owner');
        CollectionReference collectionReference = ref.collection('hotel');
        await reference.add({
          'name': ownerName,
          'number': ownerNumber,
          'collectionId': ref.id
        }).then((value) async {
          await collectionReference.add({
            'name': name,
            'logo': image,
            'location': location,
            'area': area,
            'collectionId': ref.id,
          }).then((element) async {
            await collectionReference
                .doc(element.id)
                .update({'hotelId': element.id});
          });
        });
      }
      _isLoading = false;
      message = edit == true ? 'Update was successful' : 'Owner was added';
      errorMessage = 'SUCCESSFUL';
      notifyListeners();
      return {'message': message, 'error': errorMessage};
    } on FirebaseException catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.code);
      return {'message': message, 'error': errorMessage};
    }
  }

  Future<dynamic> fetchHotelOwners() async {
    print('processing...');
    List<HotelOwners> fetchedOwners = [];
    CollectionReference ref = FirebaseFirestore.instance.collection('hotels');
    ref.get().then((value) {
      value.docs.forEach((element) {
        ref.doc(element.id).collection('owner').get().then((val) {
          val.docs.forEach((result) {
            print('ok');
            print(result.data());
          });
        });
      });
    });
    // return ref.doc().collection('owner').snapshots().forEach((element) {
    //   element.docs.forEach((element) {
    //     final _list = HotelOwners(
    //       ownerName: element['name'],
    //       ownerNumber: element['number'],
    //       id: element.id,
    //       collectionId: element['collectionId'],
    //     );
    //     print(element['name']);
    //     fetchedOwners.add(_list);
    //     _hotelOwners = fetchedOwners;
    //     notifyListeners();
    //   });
    //   print('fetched list = $_hotelOwners');
    // });
  }

  Future<Stream<QuerySnapshot>> searchOrder([String orderRef]) async {
    CollectionReference reference = FirebaseFirestore.instance
        .collection('purchases')
        .doc()
        .collection('myPurchases');
    if (orderRef == null) {
      return reference.snapshots();
    } else {
      return reference.where('orderRef', isEqualTo: orderRef).snapshots();
    }
  }

  Future confirmPendingOrders(String orderRef) async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('pendingOrders')
        .doc()
        .collection('myPendingOrders');
    await ref.where('orderRef', isEqualTo: orderRef).get().then((value) async {
      value.docs.forEach((element) async {
        String id = element.id;

        return await FirebaseFirestore.instance
            .collection('pendingOrders')
            .doc(element['documentCollectionId'])
            .collection('myPendingOrders')
            .doc(id)
            .update({'pending': false});
      });
    });
  }

  // Function for developer
  fetchAllPurchases() async {
    List fetchMyPurchases = [];
    CollectionReference reference =
        FirebaseFirestore.instance.collection('purchases');

    return await reference
        .doc()
        .collection('myPurchases')
        .snapshots()
        .forEach((element) async {
      return element.docs.forEach((value) async {
        String collectionPath = value.data()['type'];
        String productId = value.data()['productId'];
        int noOfOrder = value.data()['noOfOrder'];
        String vendorId = value.data()['vendorId'];
        notifyListeners();
        return FirebaseFirestore.instance
            .collection(collectionPath)
            .doc(productId)
            .snapshots()
            .forEach((element) async {
          final _uploadedToPurchases = AllPurchases(
            description: element.data()['description'],
            id: element.id,
            vendorId: vendorId,
            image: element.data()['image'],
            type: element.data()['type'],
            location: element.data()['location'],
            price: element.data()['price'],
            title: element.data()['title'],
            noOfOrder: noOfOrder,
          );
          fetchMyPurchases.add(_uploadedToPurchases);
          _allPurchases = fetchMyPurchases;
          notifyListeners();
        });
      });
    });
  }

  Future<Stream<QuerySnapshot>> fetchBookedRoom() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('hotels');
    return ref.doc().collection('booked').snapshots();
  }

  Future<Stream<QuerySnapshot>> pendingOrders() async {
    return FirebaseFirestore.instance
        .collection('pendingOrders')
        .doc()
        .collection('myPendingOrders')
        .where('pending', isEqualTo: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> searchRoom(
      String search, String collectionId) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('hotels');
    return ref
        .doc(collectionId)
        .collection('hotelRooms')
        .where('roomNumber', isEqualTo: search)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> searchRefCode(
      String search, String collectionId) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('hotels');
    return ref
        .doc(collectionId)
        .collection('booked')
        .where('bookRef', isEqualTo: search)
        .snapshots();
  }

  fetchHotelManagers(String collectionId) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('hotels');

    return ref.doc(collectionId).collection('managers').snapshots();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> fetchHotelRooms() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('hotels');
    return ref.doc().collection('hotelRooms').snapshots();
  }

  removeManager(String collectionId, String managerId) async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('hotels')
        .doc(collectionId)
        .collection('managers');
    await ref.doc(managerId).delete();
  }

  fetchSearchedRoom(String collectionId, String roomId) async {
    List fetched = [];
    CollectionReference ref = FirebaseFirestore.instance.collection('hotels');
    await ref
        .doc(collectionId)
        .collection('hotelRooms')
        .doc(roomId)
        .get()
        .then((value) async {
      final hotel = HotelRooms(
        noOfDays: value.data()['noOfDays'],
        checkIn: value.data()['checkIn'],
        roomNumber: value.data()['roomNumber'],
        checkOut: value.data()['checkOut'],
        image: value.data()['image'],
        available: value.data()['available'],
        title: value.data()['title'],
        price: value.data()['price'],
        details: value.data()['details'],
      );
      fetched.add(hotel);
      _hotelRooms = fetched;
      notifyListeners();
    });
  }

  // Function for developer
  Future<Map<String, dynamic>> createService(
      {String title,
      String areaHint,
      String descriptionHint,
      String timeHint}) async {
    _isLoading = true;
    String message =
        'Problem occurred. Check your internet connection and try again';
    String _title = 'ERROR';
    notifyListeners();
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('services');
      Map<String, dynamic> map = {
        'title': title,
        'areaHint': areaHint,
        'descriptionHint': descriptionHint,
        'timeHint': timeHint,
      };
      await ref.add(map);
      _isLoading = false;
      message = 'Was added successfully';
      _title = 'SUCCESSFUL';
      notifyListeners();
      return {'message': message, 'title': _title};
    } on FirebaseException catch (e) {
      print(e.code);
      return {'message': message, 'title': _title};
    }
  }

  Future<Stream<QuerySnapshot>> getConversations(String chatId) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('chatRoom');
    return users
        .doc(chatId)
        .collection('chats')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future addConversations(
      String chatId, String message, String chatRoomId, String senderId) async {
    Map<String, dynamic> messageMap = {
      'message': message,
      'chatRoomId': chatRoomId,
      'senderId': senderId,
      'sender': _authentication.id,
      'uname': 'manager',
      'time': DateTime.now().millisecondsSinceEpoch,
    };

    CollectionReference chat =
        FirebaseFirestore.instance.collection('chatRoom');

    CollectionReference _users = FirebaseFirestore.instance.collection('users');

    await chat.doc(chatId).collection('chats').add(messageMap);

    await _users.snapshots().forEach((element) {
      element.docs.forEach((element) {
        return SendPushNotifications.sendNotifications(
            element['token'], messageMap);
      });
    });
    // return SendPushNotifications.sendNotifications(userId, msg);
  }

  Future<dynamic> getChatRoom() async {
    String myId = 'ovSpotmanager';
    final List<ChatUsers> _getChatUsers = [];
    CollectionReference users =
        FirebaseFirestore.instance.collection('chatRoom');
    // String myId = _authentication.managerId;
    Stream<QuerySnapshot> future =
        users.where('users', arrayContains: myId).snapshots();
    future.forEach((element) async {
      element.docs.forEach((element) async {
        String chatRoomId = element['chatRoomId'];
        String userId =
            chatRoomId.toString().replaceAll('_', '').replaceAll(myId, '');
        FirebaseFirestore.instance
            .collection('users')
            .where('userId', isEqualTo: '$userId')
            .get()
            .asStream()
            .listen((event) async {
          event.docs.forEach((element) async {
            final fetchedChatUsers = ChatUsers(
              userId: element.data()['userId'],
              chatRoomId: chatRoomId,
              email: element.data()['email'],
              userName: element.data()['fName'],
              number: element.data()['number'],
              profileImage: element.data()['pImageUrl'],
            );
            _getChatUsers.add(fetchedChatUsers);
            _chatUsers = _getChatUsers;
            notifyListeners();
          });
        });
        return _chatUsers;
      });
    }).catchError((e) => print('firebaseError= $e'));
  }

  Future upLoadPicture(File uploadedImage, String path) async {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    FirebaseStorage fireBaseStorage = FirebaseStorage.instance;
    final imagePath = File(uploadedImage.path);
    try {
      if (uploadedImage == null) {
        return;
      }
      Reference reference = fireBaseStorage.ref('$path/$imagePath');
      UploadTask uploadTask =
          fireBaseStorage.ref('$path/$imagePath').putFile(imagePath);
      TaskSnapshot taskSnapshot = await uploadTask;
      print('Uploaded ${taskSnapshot.bytesTransferred} bytes.');
      String downloadURL = await reference.getDownloadURL();
      try {
        print(downloadURL);
      } on FirebaseException catch (e) {
        print('downloadError= $e');
      }
      _profileImagePath = uploadedImage.path;
      _profileImageUrl = downloadURL;
      notifyListeners();
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    Users(
      id: '',
      email: '',
    );
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    _isLoading = true;
    bool haserror = true;
    String message = 'Something went wrong, invalid password or userName/email';
    notifyListeners();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    try {
      await fireBaseAuth.signInWithEmailAndPassword(
          email: email.toString().trim(), password: password);

      fireBaseAuth.authStateChanges().listen((user) async {
        Future<DocumentSnapshot> future = users.doc(user.uid).get();
        future.asStream().listen((event) async {
          Map<String, dynamic> data = event.data();
          // await pref.setString('password', data['password']);
          await pref.setString('email', data['email']);
          await pref.setString('userId', data['userId']);

          String _userId = pref.getString('userId');
          String _password = pref.getString('password');
          String _email = pref.getString('email');
          _authentication = Users(
            id: _userId,
            email: _email,
            password: _password,
          );
          notifyListeners();
          String fcmToken = await firebaseMessaging.getToken();

          await users.doc(user.uid).update({
            'token': fcmToken,
          });
        });
      });
      _isLoading = false;
      haserror = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'Email not found';
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password';
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      } else if (e.code == 'network-request-failed') {
        message = 'Poor or No Data Connection! Check Your Data Connection';
      } else {
        print('error= ${e.code}');
        message = 'something went wrong';
      }
    }
    _isLoading = false;
    notifyListeners();
    return {'success': haserror, 'message': message};
  }

  Future<Map<String, dynamic>> signUp(
      [File profileImage,
      String userType,
      String email,
      String password,
      String userName,
      String fName,
      String number]) async {
    FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    _isLoading = true;
    bool hasError = true;
    String message = 'Something went wrong';
    notifyListeners();
    try {
      await fireBaseAuth.createUserWithEmailAndPassword(
          email: '$email', password: '$password');
      // firebaseAuth.verifyPhoneNumber(phoneNumber: number, verificationCompleted: null, verificationFailed: null, codeSent: null, codeAutoRetrievalTimeout: null)
      fireBaseAuth.authStateChanges().listen((user) async {
        Map<String, dynamic> userData = {
          'userId': user.uid,
          'userType': userType,
          'email': email,
          'userName': userName,
          'fName': fName,
          'number': number,
          'managerId': 'manager@mySpotMart',
          'isManager': false,
        };
        if (email == 'vicksonhezzy@gmail.com') {
          userData = userData.update(
              'isManager',
              (value) => {
                    'userId': user.uid,
                    'userType': userType,
                    'email': email,
                    'userName': userName,
                    'fName': fName,
                    'number': number,
                    'managerId': 'manager@mySpotMart',
                    'isManager': true,
                  });
          // .update('isManager', (value) => true);
          notifyListeners();
        }
        users.doc(user.uid).set(userData);
      });
      hasError = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email already exist, try sign-in';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      } else {
        print(e.code.toString());
      }
    }
    _isLoading = false;
    notifyListeners();
    return {'success': hasError, 'message': message};
  }

  authenticate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String _userId = pref.getString('userId');
    String _password = pref.getString('password');
    String _email = pref.getString('email');
    _authentication = Users(
      id: _userId,
      email: _email,
      password: _password,
    );
    notifyListeners();
  }
}

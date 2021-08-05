import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:spot_manager/models/models.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/ui_widgets/error_widget.dart';
import 'package:spot_manager/ui_widgets/image_container_widget.dart';

class UpdateGoodsRestaurant extends StatefulWidget {
  final String image;
  final String type;
  final String title;
  final String description;
  final String price;
  final bool edit;
  final String houseId;
  final String vendorId;

  const UpdateGoodsRestaurant(
      {this.image,
        this.vendorId,
        this.type,
        this.houseId,
        this.title,
        this.description,
        this.price,
        this.edit});

  @override
  _UpdateGoodsRestaurantState createState() => _UpdateGoodsRestaurantState();
}

class _UpdateGoodsRestaurantState extends State<UpdateGoodsRestaurant> {
  final formKey = GlobalKey<FormState>();
  String dropDownType = 'select type';
  String dropDownGoodsCategory = 'select Category';
  String dropDownFoodCategory = 'select Category';

  UiWidgets uiWidgets = UiWidgets();

  final Map<String, dynamic> _infoData = {
    'image': null,
    'title': null,
    'description': null,
    'type': null,
    'category': null,
    'price': null,
  };

  setImage(Models model, image) {
    setState(() {
      model.selectImage(false);
      _infoData['image'] = image;
    });
  }

  onSubmit(Models model) async {
    setState(() {
      if (_infoData['type'] == null || _infoData['type'] == 'select type') {
        model.typeNeeded(true);
      } else {
        model.typeNeeded(false);
      }
      // if (_infoData['category'] == null ||
      //     _infoData['category'] == 'Properties&Goods') {
      //   model.goodsCategoryNeeded(true);
      // } else {
      //   model.goodsCategoryNeeded(false);
      // }
      // if (_infoData['category'] == null ||
      //     _infoData['category'] == 'Foods&Drinks') {
      //   model.foodCategoryNeeded(true);
      // } else {
      //   model.foodCategoryNeeded(false);
      // }
//      model.locationNeeded(true);
      if (model.image == null) {
        setState(() {
          model.neededImage(true);
        });
      } else {
        setState(() {
          model.neededImage(false);
        });
      }
    });
    if (formKey.currentState.validate()) {
      if (model.typeSelected == true ||
          model.chooseImage == true
      // ||
          // model.foodCategorySelected == true ||
          // model.goodsCategorySelected == true
      ) {
        return null;
      }
      if (widget.type != null) {
        model.typeNeeded(false);
        // model.goodsCategoryNeeded(false);
        // model.foodCategoryNeeded(false);
        model.selectType(false);
        // model.selectGoodsCategory(false);
        // model.selectFoodCategory(false);
        // model.locationNeeded(false);
        // model.selectLocation(false);
      }
      if (model.chooseImage == false) {
        setState(() {
          model.neededImage(false);
          model.selectImage(false);
        });
      }
      if (model.typeSelected == false) {
        setState(() {
          model.typeNeeded(false);
          model.selectType(false);
        });
      }
      // if (model.goodsCategorySelected == false) {
      //   setState(() {
      //     model.goodsCategoryNeeded(false);
      //     model.selectGoodsCategory(false);
      //     model.foodCategoryNeeded(false);
      //     model.selectFoodCategory(false);
      //   });
      // }
      // if (model.foodCategorySelected == false) {
      //   setState(() {
      //     model.foodCategoryNeeded(false);
      //     model.selectFoodCategory(false);
      //     model.goodsCategoryNeeded(false);
      //     model.selectGoodsCategory(false);
      //   });
      // }
      if (model.typeSelected == false &&
          model.chooseImage == false
      // &&
          // model.goodsCategorySelected == false &&
          // model.foodCategorySelected
      ) {
        String type = widget.type == null ? dropDownType : widget.type;
        model
            .updateSells(
          _infoData['image'],
          _infoData['title'],
          _infoData['description'],
          _infoData['price'],
          type,
          widget.houseId,
          widget.edit,
          widget.description,
          widget.price,
          widget.title,
          dropDownGoodsCategory,
          dropDownFoodCategory,
        )
            .then((Map<String, dynamic> value) {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              elevation: 2,
              title: Text(value['uploadError'] == false
                  ? 'Successful'
                  : 'Error Occurred!'),
              content: Text(value['success']),
              actions: [
                Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(2),
                  child: TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      // model.fetchMyPost();
                      if (value['uploadError'] == false) {
                        setState(() {
                          model.setImage(null, null);
                          // model.fetchMyPost();
                        });
                        Navigator.pop(context);
                        return Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
      }
    }
  }

  Widget errorWidgets(Models model) {
    if (dropDownType == 'Foods&Drinks') {
      return uiWidgets.chooseFoodCategoryValidationText(
          model,
          dropDownFoodCategory,
          'select Category',
          'select Category',
          widget.type);
    }
    if (dropDownType == 'Properties&Goods') {
      return uiWidgets.chooseGoodsCategoryValidationText(
          model,
          dropDownGoodsCategory,
          'select Category',
          'select Category',
          widget.type);
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Models>(
        builder: (context, child, Models model) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Post Sells',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HouseImageContainer(setImage: setImage, image: widget.image),
                  SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Material(
                            elevation: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: IgnorePointer(
                                ignoring: widget.edit == true ? true : false,
                                child:
                                DropdownButton(
                                  isExpanded: true,
                                  iconEnabledColor: Colors.black87,
                                  dropdownColor: Colors.white,
                                  onChanged: (String value) {
                                    setState(() {
                                      _infoData['type'] = value;
                                      dropDownType = value;
                                    });
                                  },
                                  value: widget.type != null
                                      ? widget.type
                                      : dropDownType,
                                  elevation: 16,
                                  items: <String>[
                                    'select type',
                                    'Foods&Drinks',
                                    'Properties&Goods',
                                  ].map<DropdownMenuItem<String>>((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: e == 'select type'
                                          ? Text(
                                        e,
                                        style: TextStyle(color: Colors.grey),
                                      )
                                          : Text(
                                        e,
                                        style:
                                        TextStyle(color: Colors.black87),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        uiWidgets.chooseTypeValidationText(model, dropDownType,
                            'select type', 'select type', widget.type),
                        dropDownType == 'Foods&Drinks'
                            ? Container(
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Material(
                            elevation: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: IgnorePointer(
                                ignoring: widget.edit == true ? true : false,
                                child: SearchableDropdown.single(
                                  items: model.getFoodCategoryList,
                                  onChanged: (String value) {
                                    setState(() {
                                      dropDownFoodCategory = value;
                                    });
                                  },
                                  hint: 'Select type',
                                  value: widget.type == null ? '' : widget.type,
                                  // validator: (String value) {
                                  //   if (value.isEmpty) {
                                  //     return 'select field';
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                ),
                                // DropdownButton(
                                //   isExpanded: true,
                                //   iconEnabledColor: Colors.black87,
                                //   dropdownColor: Colors.white,
                                //   onChanged: (String value) {
                                //     setState(() {
                                //       _infoData['category'] = value;
                                //       dropDownFoodCategory = value;
                                //     });
                                //   },
                                //   value: widget.type != null
                                //       ? widget.type
                                //       : dropDownFoodCategory,
                                //   elevation: 16,
                                //   items: <String>[
                                //     'select Category',
                                //     'Foods',
                                //     'Desserts',
                                //     'Bakeries',
                                //     'Drinks',
                                //   ].map<DropdownMenuItem<String>>((e) {
                                //     return DropdownMenuItem<String>(
                                //       value: e,
                                //       child: e == 'select Category'
                                //           ? Text(
                                //         e,
                                //         style: TextStyle(
                                //             color: Colors.grey),
                                //       )
                                //           : Text(
                                //         e,
                                //         style: TextStyle(
                                //             color: Colors.black87),
                                //       ),
                                //     );
                                //   }).toList(),
                                // ),
                              ),
                            ),
                          ),
                        )
                            : Container(),
                        dropDownType == 'Properties&Goods'
                            ? Container(
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Material(
                            elevation: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: IgnorePointer(
                                ignoring: widget.edit == true ? true : false,
                                child: SearchableDropdown.single(
                                  items: model.getGoodsCategoryList,
                                  onChanged: (String value) {
                                    setState(() {
                                      dropDownGoodsCategory = value;
                                    });
                                  },
                                  hint: 'Select type',
                                  value: widget.type == null ? '' : widget.type,
                                  // validator: (String value) {
                                  //   if (value.isEmpty) {
                                  //     return 'select field';
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                ),
                                // DropdownButton(
                                //   isExpanded: true,
                                //   iconEnabledColor: Colors.black87,
                                //   dropdownColor: Colors.white,
                                //   onChanged: (value) {
                                //     setState(() {
                                //       dropDownGoodsCategory =
                                //           value.toString();
                                //     });
                                //   },
                                //   value: widget.type != null
                                //       ? widget.type
                                //       : dropDownGoodsCategory,
                                //   elevation: 16,
                                //   items: <String>[
                                //     'select Category',
                                //     "Men's Fashion",
                                //     "Women's Fashion",
                                //     'Kids Fashion',
                                //     "Women's Footwear",
                                //     "Men's Footwear",
                                //     'Kids Footwear',
                                //     'Computers',
                                //     'Electronics',
                                //     'Furniture',
                                //     'Games',
                                //     'Generators',
                                //     'Groceries',
                                //     'Health & Beauty',
                                //     'Home & Office',
                                //     'Kitchen',
                                //     'Kids Bags',
                                //     "Women's Bags'",
                                //     "Men's Bags & Wallets'",
                                //     'Travelling Bags',
                                //     'Laptop Bags',
                                //     'Phones & Tablets',
                                //   ].map<DropdownMenuItem<String>>((e) {
                                //     return DropdownMenuItem<String>(
                                //       value: e,
                                //       child: e == 'select Category'
                                //           ? Text(
                                //         e,
                                //         style: TextStyle(
                                //             color: Colors.grey),
                                //       )
                                //           : Text(
                                //         e,
                                //         style: TextStyle(
                                //             color: Colors.black87),
                                //       ),
                                //     );
                                //   }).toList(),
                                // ),
                              ),
                            ),
                          ),
                        )
                            : Container(),
                        // errorWidgets(model),
                        Container(
                          width: double.infinity,
                          margin:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                          child: Material(
                            elevation: 2,
                            child: TextFormField(
                              initialValue: widget.title,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'enter title';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.edit),
                                  hintText: 'enter title'),
                              onFieldSubmitted: (newValue) {
                                setState(() {
                                  _infoData['title'] = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                          child: Material(
                            elevation: 2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: widget.price,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'enter price';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.edit),
                                  hintText: 'enter price'),
                              onFieldSubmitted: (newValue) {
                                setState(() {
                                  _infoData['price'] = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                          child: Material(
                            elevation: 2,
                            child: TextFormField(
                              initialValue: widget.description,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'enter description';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.edit),
                                  hintText: 'enter description'),
                              onFieldSubmitted: (newValue) {
                                setState(() {
                                  _infoData['description'] = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          margin: EdgeInsets.all(10),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              color: Color(0xffff3a5a),
                            ),
                            child: model.postUploading == true
                                ? Center(child: CircularProgressIndicator())
                                : TextButton(
                                child: Text(
                                  'POST',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                onPressed: () => onSubmit(model)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

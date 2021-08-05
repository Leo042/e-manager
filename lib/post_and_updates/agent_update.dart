import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:spot_manager/models/models.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/ui_widgets/error_widget.dart';
import 'package:spot_manager/ui_widgets/image_container_widget.dart';

class AgentUpdate extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final String location;
  final String price;
  final bool edit;
  final String houseId;
  final String vendorId;

  const AgentUpdate(
      {this.image,
      this.vendorId,
      this.houseId,
      this.title,
      this.description,
      this.price,
      this.location,
      this.edit});

  @override
  _AgentUpdateState createState() => _AgentUpdateState();
}

class _AgentUpdateState extends State<AgentUpdate> {
  final formKey = GlobalKey<FormState>();
  String dropDownType = '';
  String dropDownLocation = '';
  UiWidgets uiWidgets = UiWidgets();

  final Map<String, dynamic> _infoData = {
    'image': null,
    'type': null,
    'location': null,
    'description': null,
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
      // if (_infoData['type'] == null || _infoData['type'] == 'select type') {
      //   model.typeNeeded(true);
      // } else {
      //   model.typeNeeded(false);
      // }
      // if (_infoData['location'] == null ||
      //     _infoData['location'] == 'select location') {
      //   model.locationNeeded(true);
      // } else {
      //   model.locationNeeded(false);
      // }
      if (_infoData['image'] == null) {
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
      if (
          // model.typeSelected == true ||
          //     model.locationSelected == true ||

          model.chooseImage == true) {
        return null;
      }
      // if (widget.location != null && widget.title != null) {
      //   setState(() {
      //     model.locationNeeded(false);
      //     model.selectLocation(false);
      //     model.typeNeeded(false);
      //     model.selectType(false);
      //     model.goodsCategoryNeeded(false);
      //     model.foodCategoryNeeded(false);
      //     model.selectGoodsCategory(false);
      //     model.selectFoodCategory(false);
      //   });
      // }
      if (model.chooseImage == false) {
        setState(() {
          model.neededImage(false);
          model.selectImage(false);
        });
      }
      // if (model.typeSelected == false) {
      //   setState(() {
      //     model.typeNeeded(false);
      //     model.selectType(false);
      //   });
      // }
      // if (model.locationSelected == false) {
      //   setState(() {
      //     model.locationNeeded(false);
      //     model.selectLocation(false);
      //   });
      // }
      if (
          // model.locationSelected == false &&
          //     model.typeSelected == false &&
          model.chooseImage == false) {
        // String type = widget.title == null ? dropDownType : widget.title;
        // String location =
        //     widget.location == null ? dropDownLocation : widget.location;
        model
            .updateHouse(
          _infoData['image'],
          // type,
          _infoData['type'],
          // location,
          _infoData['location'],
          _infoData['description'],
          _infoData['price'],
          widget.edit,
          widget.houseId,
        )
            .then((Map<String, dynamic> value) {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              elevation: 2,
              title: Text('FeedBack'),
              content: Text(value['success']),
              actions: [
                Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(2),
                  child: TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      // model.fetchMyPost();
                      setState(() {
                        model.setImage(null, null);
                        // model.fetchMyPost();
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Models>(
        builder: (context, child, Models model) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Post Lodge',
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
                            child: SearchableDropdown.single(
                              items: model.getHouseType,
                              onChanged: (String value) {
                                setState(() {
                                  _infoData['type'] = value;
                                });
                              },
                              hint: 'Select type',
                              value: widget.title == null ? '' : widget.title,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'select field';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            // DropdownButton(
                            //   isExpanded: true,
                            //   iconEnabledColor: Colors.black87,
                            //   dropdownColor: Colors.white,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       dropDownType = value;
                            //     });
                            //   },
                            //   value: widget.title != null
                            //       ? widget.title
                            //       : dropDownType,
                            //   elevation: 16,
                            //   items: <String>[
                            //     'select type',
                            //     'Self-Con',
                            //     'One-Room',
                            //     'Apartment',
                            //   ].map<DropdownMenuItem<String>>((e) {
                            //     return DropdownMenuItem<String>(
                            //       value: e,
                            //       child: e == 'select type'
                            //           ? Text(
                            //         e,
                            //         style: TextStyle(color: Colors.grey),
                            //       )
                            //           : Text(
                            //         e,
                            //         style:
                            //         TextStyle(color: Colors.black87),
                            //       ),
                            //     );
                            //   }).toList(),
                            // ),
                          ),
                        ),
                      ),
                    ),
                    // uiWidgets.chooseTypeValidationText(model, dropDownType,
                    //     'select type', 'select lodge type', widget.title),
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
                            child: SearchableDropdown.single(
                              items: model.getHouseLocation,
                              onChanged: (String value) {
                                setState(() {
                                  _infoData['location'] = value;
                                });
                              },
                              hint: 'Select type',
                              value: widget.location == null ? '' : widget.location,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'select field';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            // DropdownButton(
                            //   isExpanded: true,
                            //   iconEnabledColor: Colors.black87,
                            //   dropdownColor: Colors.white,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       dropDownLocation = value;
                            //     });
                            //   },
                            //   value: widget.location != null
                            //       ? widget.location
                            //       : dropDownLocation,
                            //   elevation: 16,
                            //   items: <String>[
                            //     'select location',
                            //     'Odenigwe',
                            //     'Hill-top',
                            //     'Odim',
                            //     'Behind-flat',
                            //     'Others'
                            //   ].map<DropdownMenuItem<String>>((e) {
                            //     return DropdownMenuItem<String>(
                            //       value: e,
                            //       child: e == 'select location'
                            //           ? Text(
                            //         e,
                            //         style: TextStyle(color: Colors.grey),
                            //       )
                            //           : Text(
                            //         e,
                            //         style:
                            //         TextStyle(color: Colors.black87),
                            //       ),
                            //     );
                            //   }).toList(),
                            // ),
                          ),
                        ),
                      ),
                    ),
                    // uiWidgets.chooseLocationValidationText(
                    //     model,
                    //     dropDownLocation,
                    //     'select location',
                    //     'select location',
                    //     widget.location),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Material(
                        elevation: 2,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue:
                              widget.price == null ? '' : widget.price,
                          validator: (value) {
                            if (value.length < 1) {
                              return 'enter lodge price';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.edit),
                              hintText: 'Enter price'),
                          onFieldSubmitted: (newValue) {
                            setState(() {
                              _infoData['price'] = newValue.replaceAll(',', '');
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
                          textCapitalization: TextCapitalization.sentences,
                          initialValue: widget.description == null ||
                                  widget.description.isEmpty
                              ? ''
                              : widget.description,
                          validator: (value) {
                            if (value.length < 1) {
                              return 'enter lodge description';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.edit),
                              hintText: 'Enter description'),
                          onFieldSubmitted: (value) {
                            setState(() {
                              _infoData['description'] = value;
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

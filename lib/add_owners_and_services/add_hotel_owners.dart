import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/ui_widgets/alertDialog.dart';
import 'package:spot_manager/ui_widgets/container_widgets.dart';
import 'package:spot_manager/ui_widgets/image_container_widget.dart';

class AddHotelOwner extends StatefulWidget {
  final String logo;
  final String name;
  final String ownerName;
  final String ownerNumber;
  final String location;
  final String area;
  final String collectionId;
  final String id;
  final bool edit;

  AddHotelOwner(
      {this.logo,
      this.name,
      this.location,
      this.ownerNumber,
      this.ownerName,
      this.area,
      this.collectionId,
      this.id,
      this.edit});

  @override
  _AddHotelOwnerState createState() => _AddHotelOwnerState();
}

class _AddHotelOwnerState extends State<AddHotelOwner> {
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> _infoData = {
    'image': null,
    'ownerName': '',
    'ownerNumber': '',
    'name': '',
    'location': '',
    'area': '',
  };

  setImage(Models model, image) {
    setState(() {
      model.selectImage(false);
      _infoData['image'] = image;
    });
  }

  _submit(Models model) {
    model.selectImage(true);
    model.neededImage(true);
    if(model.image != null){
      model.selectImage(false);
      model.neededImage(false);
    }
    if (formKey.currentState.validate() && model.imageNeeded == false) {
      formKey.currentState.save();
      print(_infoData);
      model
          .addHotelOwner(
              _infoData['image'],
              _infoData['name'],
              _infoData['ownerName'],
              _infoData['ownerNumber'],
              _infoData['location'],
              _infoData['area'],
              widget.collectionId,
              widget.id,
              widget.logo,
              widget.edit)
          .then((value) {
        AlertWidget().alertWidget(context, value['error'], value['message']);
        model.fetchHotelOwners();
        model.fetchHotels();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add hotel Owner'),
      ),
      body: ScopedModelDescendant<Models>(
          builder: (context, child, Models model) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                HouseImageContainer(
                  model: model,
                  setImage: setImage,
                  image: widget.logo,
                  buttonText: 'Add Image',
                  displayText: 'hotel image will display here',
                ),
                SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                        child: Material(
                          elevation: 2,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            initialValue:
                                widget.name == null ? '' : widget.name,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'enter hotel name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.edit),
                                hintText: 'Enter hotel name'),
                            onSaved: (newValue) {
                              setState(() {
                                _infoData['name'] = newValue;
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
                            textCapitalization: TextCapitalization.words,
                            initialValue: widget.ownerName == null
                                ? ''
                                : widget.ownerName,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'enter owner name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.edit),
                                hintText: 'Enter owner name'),
                            onSaved: (newValue) {
                              setState(() {
                                _infoData['ownerName'] = newValue;
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
                            keyboardType: TextInputType.phone,
                            initialValue: widget.ownerNumber == null
                                ? ''
                                : widget.ownerNumber,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'enter owner number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.edit),
                                hintText: 'Enter owner number'),
                            onSaved: (newValue) {
                              setState(() {
                                _infoData['ownerNumber'] = newValue;
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
                            textCapitalization: TextCapitalization.words,
                            initialValue:
                                widget.location == null ? '' : widget.location,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'enter hotel location';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.edit),
                                hintText: 'Enter location'),
                            onSaved: (newValue) {
                              setState(() {
                                _infoData['location'] = newValue;
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
                            textCapitalization: TextCapitalization.words,
                            initialValue:
                                widget.area == null ? '' : widget.area,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'enter hotel area';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.edit),
                                hintText: 'Enter area'),
                            onSaved: (newValue) {
                              setState(() {
                                _infoData['area'] =
                                    newValue.replaceAll(',', '');
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ContainerWidgets().container(
                        context: context,
                        function: _submit,
                        text: 'ADD',
                        model: model,
                      ),
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

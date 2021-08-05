import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/ui_widgets/alertDialog.dart';
import 'package:spot_manager/ui_widgets/container_widgets.dart';
import 'package:spot_manager/ui_widgets/image_container_widget.dart';

class AddCategory extends StatefulWidget {
  final String image;
  final String name;
  final bool selection;
  final String collectionName;
  final bool isHouseType;
  final bool isHouseLocation;
  final String displayText;
  final String buttonText;

  AddCategory(
      {this.image,
      @required this.buttonText,
      @required this.displayText,
      this.collectionName,
      this.name,
      this.selection,
      this.isHouseType,
      this.isHouseLocation});

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  Map<String, dynamic> _infoData = {
    'image': null,
    'name': '',
  };
  GlobalKey<FormState> formKey = GlobalKey();

  setImage(Models model, image) {
    setState(() {
      model.selectImage(false);
      _infoData['image'] = image;
    });
  }

  _submit(Models model) {
    model.selectImage(true);
    model.neededImage(true);
    if (model.image != null) {
      model.selectImage(false);
      model.neededImage(false);
    }
    if (widget.isHouseLocation == true || widget.isHouseType == true) {
      if (formKey.currentState.validate()) {
        model
            .createFoodCategory(
                name: _infoData['name'],
                image: _infoData['image'],
                category: widget.collectionName)
            .then((value) {
          AlertWidget().alertWidget(context, value['title'], value['message']);
        });
      }
    } else {
      if (formKey.currentState.validate() && model.imageNeeded == false) {
        model
            .createFoodCategory(
                name: _infoData['name'],
                image: _infoData['image'],
                category: widget.collectionName)
            .then((value) {
          AlertWidget().alertWidget(context, value['title'], value['message']);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Models>(
      builder: (context, child, Models model) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                widget.selection == true ||
                        widget.isHouseLocation == true ||
                        widget.isHouseType == true
                    ? Container()
                    : HouseImageContainer(
                        image: widget.image,
                        setImage: setImage,
                        model: model,
                        displayText: widget.displayText,
                        buttonText: widget.buttonText,
                      ),
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
                            initialValue:
                                widget.name == null ? '' : widget.name,
                            validator: (value) {
                              if (value.length < 1) {
                                return widget.selection == true
                                    ? 'enter selection name'
                                    : widget.isHouseType == true
                                        ? 'enter house type'
                                        : widget.isHouseLocation == true
                                            ? 'enter house location'
                                            : 'enter category name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.edit),
                                hintText: widget.selection == true
                                    ? 'Enter selection name'
                                    : widget.isHouseType == true
                                        ? 'Enter house type'
                                        : widget.isHouseLocation == true
                                            ? 'Enter house location'
                                            : 'Enter category name'),
                            onFieldSubmitted: (newValue) {
                              setState(() {
                                _infoData['name'] = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ContainerWidgets().container(
                        model: model,
                        text: 'ADD',
                        function: _submit,
                        context: context,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

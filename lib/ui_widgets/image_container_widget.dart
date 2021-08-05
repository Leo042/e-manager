import 'dart:io';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/ui_widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class HouseImageContainer extends StatefulWidget {
  final Function setImage;
  final String image;
  final String displayText;
  final String buttonText;

  final Models model;

  HouseImageContainer({@required this.buttonText, @required this.displayText, this.setImage, this.image, this.model});

  @override
  _HouseImageContainerState createState() => _HouseImageContainerState();
}

class _HouseImageContainerState extends State<HouseImageContainer> {
  UiWidgets uiImageWidgets = UiWidgets();

  errorMessage(Models model) {
    if (model.chooseImage == false) {
      return Container();
    } else {
      return uiImageWidgets.chooseImageValidationText(model, 'choose image');
    }
  }

  final picker = ImagePicker();

  Future<void> retrieveLostData() async{
    final LostData response = await picker.getLostData();
    if(response.isEmpty){
      return;
    }
    if(response.file != null){
      if(response.type == RetrieveType.video){
        return null;
      }else{
        setState(() {
          widget.model.setImage(File(response.file.path), false);
        });
      }
    }
  }

  Future _pickImage(Models model, ImageSource source) async {
    // final imagePicker =
    // await ImagePickerGC.pickImage(context: context, source: source);
    PickedFile pickedFile = await picker.getImage(source: source);
    // await Future.delayed(Duration(seconds: 2));
    setState(() {
      if (pickedFile != null) {
        final File image = File(pickedFile.path);

        model.selectImage(false);
        model.neededImage(false);
        model.setImage(image, false);
        widget.setImage(model, image);

        print(model.chooseImage);
        Navigator.pop(context);
      } else {
        print('No image found');
      }
    });
  }

  Widget imageContainerDisplay(Models model) {
    if (widget.image != null) {
      model.neededImage(false);
      model.selectImage(false);
      return Image.network(widget.image);
    } else {
      if (model.image == null) {
        return Center(
          child: Text(widget.displayText),
        );
      } else {
        return Image.file(model.image);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Models>(
        builder: (context, child, Models model) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 400,
                alignment: Alignment.center,
                child: Material(
                    elevation: 1,
                    child: FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder: (context, AsyncSnapshot<void> snapshot) {
                        return imageContainerDisplay(model);
                      },
                    )),
              ),
//          uiImageWidgets.chooseValidationText(model, 'choose a picture'),
              errorMessage(model),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3),
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.circular(5)),
                child: GestureDetector(
                  onTap: () => _imagePicker(model),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo),
                      SizedBox(width: 3),
                      Text(
                        widget.buttonText,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }

  _imagePicker(Models model) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          final Color _color = Theme.of(context).accentColor;
          return Container(
              height: 150,
              padding: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Choose',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              _pickImage(model, ImageSource.camera);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera,
                                  color: _color,
                                ),
                                Text('Camera')
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _pickImage(model, ImageSource.gallery);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.image,
                                  color: _color,
                                ),
                                Text('Gallery')
                              ],
                            ),
                          )
                        ])
                  ],
                ),
              ));
        });
  }
}

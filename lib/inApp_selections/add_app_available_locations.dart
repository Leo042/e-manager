import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/ui_widgets/alertDialog.dart';
import 'package:spot_manager/ui_widgets/container_widgets.dart';

class AddLocation extends StatefulWidget {
  final String location;
  AddLocation(this.location);
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  Map<String, dynamic> _infoData = {
    'name': '',
  };
  GlobalKey<FormState> formKey = GlobalKey();

  _submit(Models model) {
    if (formKey.currentState.validate()) {
      model.addAvailableLocations(_infoData['name']).then((value) {
        AlertWidget().alertWidget(context, value['title'], value['message']);
      });
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
                Container(),
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
                            initialValue: widget.location,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'enter location';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter app available locations',
                              prefixIcon: Icon(Icons.edit),
                            ),
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

class AddAvailableLocation extends StatelessWidget {
  final String location;
  AddAvailableLocation(this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add app available Location'),
      ),
      body: AddLocation(location),
    );
  }
}

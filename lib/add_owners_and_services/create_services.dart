import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/ui_widgets/alertDialog.dart';
import 'package:spot_manager/ui_widgets/container_widgets.dart';

class CreateService extends StatefulWidget {
  @override
  _CreateServiceState createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  Map<String, dynamic> _infoData = {
    'title': '',
    'areaHint': '',
    'descriptionHint': '',
    'timeHint': '',
  };
  GlobalKey<FormState> formKey = GlobalKey();

  _submit(Models model) {
    if (formKey.currentState.validate()) {
      model
          .createService(title: _infoData['title'], areaHint: _infoData['areaHint'],
          descriptionHint: _infoData['descriptionHint'], timeHint: _infoData['timeHint'])
          .then((value) {
        AlertWidget().alertWidget(context, value['title'], value['message']);
      });
    }
  }

  Container container(String errorText, String hint, String setter) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: Material(
        elevation: 2,
        child: TextFormField(
          validator: (value) {
            if (value.length < 1) {
              return '$errorText';
            }
            return null;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            prefixIcon: Icon(Icons.edit),
          ),
          onFieldSubmitted: (newValue) {
            setState(() {
              setter = newValue;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Services'),
      ),
      body: ScopedModelDescendant<Models>(
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
                        container('enter service title', 'Enter title',
                            _infoData['title']),
                        container('enter area hint',
                            'Enter area hint', _infoData['areaHint']),
                        container('enter description hint', 'Enter description hint',
                            _infoData['descriptionHint']),
                        container('enter time hint', 'Enter time hint',
                            _infoData['timeHint']),
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
      ),
    );
  }
}

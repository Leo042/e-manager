import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/ui_widgets/alertDialog.dart';
import 'package:spot_manager/ui_widgets/container_widgets.dart';

class CreateInvestment extends StatefulWidget {
  @override
  _CreateInvestmentState createState() => _CreateInvestmentState();
}

class _CreateInvestmentState extends State<CreateInvestment> {
  Map<String, dynamic> _infoData = {
    'percentage': '',
    'noOfMonths': '',
    'terms': '',
    'makeInvestment': null,
  };
  GlobalKey<FormState> formKey = GlobalKey();

  _submit(Models model) {
    if (formKey.currentState.validate()) {
      model
          .canInvest(_infoData['makeInvestment'], _infoData['percentage'],
              _infoData['noOfMonths'], _infoData['terms'])
          .then((value) {
        AlertWidget().alertWidget(context, value['title'], value['message']);
      });
    }
  }

  Container container(String errorText, String hint, String setter,
      [bool isTerms]) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: Material(
        elevation: 2,
        child: TextFormField(
          keyboardType:
              isTerms == true ? TextInputType.multiline : TextInputType.number,
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
        title: Text('Add Investment'),
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
                        container('enter percentage', 'Enter percentage',
                            _infoData['percentage']),
                        container('enter month rage for payment',
                            'Enter month range', _infoData['noOfMonths']),
                        container('enter terms', 'Enter terms',
                            _infoData['terms'], true),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                'Turn on investment',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Switch(
                              value: true,
                              onChanged: (value) {
                                setState(() {
                                  _infoData['makeInvestment'] = value;
                                });
                              },
                            ),
                          ],
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
      ),
    );
  }
}

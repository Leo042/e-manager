import 'package:flutter/material.dart';
import 'package:spot_manager/models/models.dart';

class ContainerWidgets {
  Widget container(
      {BuildContext context, Function function, Models model, String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).primaryColor,
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: model.isLoading == true
          ? CircularProgressIndicator()
          : TextButton(
              child: Text(text, style: TextStyle(color: Colors.white)),
              onPressed: () => function(model),
            ),
    );
  }
}

import 'package:spot_manager/models/models.dart';
import 'package:flutter/material.dart';

class UiWidgets {
  chooseValidationText(
      Models model, String dropDownType, String header, String errorMessage) {
    if (model.choose != true) {
      return Container();
    }
    if (dropDownType != header) {
      model.chooseNeeded(false);
      model.selectChoose(false);
      return Container();
    }
    if (model.choose == true && dropDownType == header) {
      model.selectChoose(true);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
        child: Text(
          errorMessage,
          style: TextStyle(
              color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal),
        ),
      );
    }
  }

  chooseTypeValidationText(Models model, String dropDownType, String header,
      String errorMessage, String initialValue) {
    if (model.chooseType != true) {
      return Container();
    }
    if (dropDownType != header || initialValue != null) {
      model.typeNeeded(false);
      model.selectType(false);
      return Container();
    }
    if ((model.chooseType == true && dropDownType == header) ||
        initialValue == null) {
      model.selectType(true);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
        child: Text(
          errorMessage,
          style: TextStyle(
              color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal),
        ),
      );
    }
  }

  chooseFoodCategoryValidationText(Models model, String dropDownType,
      String header, String errorMessage, String initialValue) {
    if (model.chooseFoodCategory != true) {
      return Container();
    }
    if (dropDownType != header || initialValue != null) {
      model.foodCategoryNeeded(false);
      model.selectFoodCategory(false);
      return Container();
    }
    if ((model.chooseFoodCategory == true && dropDownType == header) ||
        initialValue == null) {
      model.selectFoodCategory(true);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
        child: Text(
          errorMessage,
          style: TextStyle(
              color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal),
        ),
      );
    }
  }

  chooseGoodsCategoryValidationText(Models model, String dropDownType,
      String header, String errorMessage, String initialValue) {
    if (model.chooseGoodsCategory != true) {
      return Container();
    }
    if (dropDownType != header || initialValue != null) {
      model.goodsCategoryNeeded(false);
      model.selectGoodsCategory(false);
      model.locationNeeded(false);
      model.selectLocation(false);
      return Container();
    }
    if ((model.chooseGoodsCategory == true && dropDownType == header) ||
        initialValue == null) {
      model.selectGoodsCategory(true);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
        child: Text(
          errorMessage,
          style: TextStyle(
              color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal),
        ),
      );
    }
  }

  chooseLocationValidationText(Models model, String dropDownType, String header,
      String errorMessage, String initialValue) {
    if (model.chooseLocation != true) {
      return Container();
    }
    if (dropDownType != header || initialValue != null) {
      model.locationNeeded(false);
      model.selectLocation(false);
      model.goodsCategoryNeeded(false);
      model.selectGoodsCategory(false);
      return Container();
    }
    if ((model.chooseLocation == true && dropDownType == header) ||
        initialValue == null) {
      model.selectLocation(true);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
        child: Text(
          errorMessage,
          style: TextStyle(
              color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal),
        ),
      );
    }
  }

  chooseImageValidationText(Models model, String errorMessage) {
    if (model.imageNeeded == false) {
      model.selectImage(false);
      return Container();
    }
    if (model.imageNeeded != true) {
      return Container();
    }
    if (model.image != null) {
      model.selectImage(false);
      model.neededImage(false);
      return Container();
    }
    if (model.imageNeeded == true) {
      model.selectImage(true);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
        child: Text(
          errorMessage,
          style: TextStyle(
              color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal),
        ),
      );
    }
  }
}

//class UiTypeWidgets {
//  chooseValidationText(
//      Models model, String dropDownType, String header, String errorMessage, String initialValue) {
//    if (model.chooseType != true) {
//      return Container();
//    }
//    if ((model.chooseType == true && dropDownType == header) || initialValue == null) {
//      model.selectType(true);
//      return Container(
//        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
//        child: Text(
//          errorMessage,
//          style: TextStyle(
//              color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal),
//        ),
//      );
//    }
//    if (dropDownType != header || initialValue != null) {
//      model.typeNeeded(false);
//      model.selectType(false);
//      return Container();
//    }
//  }
//}
//
//class UiGoodsCategoryWidgets {
//  chooseValidationText(
//      Models model, String dropDownType, String header, String errorMessage, String initialValue) {
//    if (model.chooseGoodsCategory != true) {
//      return Container();
//    }
//    if ((model.chooseGoodsCategory == true && dropDownType == header) || initialValue == null) {
//      model.selectGoodsCategory(true);
//      return Container(
//        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
//        child: Text(
//          errorMessage,
//          style: TextStyle(
//              color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal),
//        ),
//      );
//    }
//    if (dropDownType != header || initialValue != null) {
//      model.goodsGategoryNeeded(false);
//      model.selectGoodsCategory(false);
//      return Container();
//    }
//  }
//}
//
//class UiLocationWidgets {
//  chooseValidationText(
//      Models model, String dropDownType, String header, String errorMessage, String initialValue) {
//    if (model.chooseLocation != true) {
//      return Container();
//    }
//    if ((model.chooseLocation == true && dropDownType == header) || initialValue == null) {
//      model.selectLocation(true);
//      return Container(
//        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
//        child: Text(
//          errorMessage,
//          style: TextStyle(
//              color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal),
//        ),
//      );
//    }
//    if (dropDownType != header || initialValue != null) {
//      model.locationNeeded(false);
//      model.selectLocation(false);
//      return Container();
//    }
//  }
//}
//
//class UiImageWidgets {
//  chooseValidationText(Models model, String errorMessage) {
//    if(model.imageNeeded == false){
//      model.selectImage(false);
//      return Container();
//    }
//    if (model.imageNeeded != true) {
//      return Container();
//    }
//    if(model.image != null){
//      model.selectImage(false);
//      model.neededImage(false);
//      return Container();
//    }
//    if(model.imageNeeded == true) {
//      model.selectImage(true);
//      return Container(
//        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 5),
//        child: Text(
//          errorMessage,
//          style: TextStyle(
//              color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal),
//        ),
//      );
//    }
//  }
//}

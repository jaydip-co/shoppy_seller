import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppy_seller/Screen/Home/Home.dart';
import 'package:shoppy_seller/Screen/Home/Widget/HomDashBoard.dart';
import 'package:shoppy_seller/Screen/Home/Widget/HomeDesk.dart';
import 'package:shoppy_seller/Screen/Home/Widget/OrderDesc.dart';

import 'package:shoppy_seller/Screen/Home/Widget/ProductDesk.dart';
import 'package:shoppy_seller/Screen/Home/Widget/SettingDesc.dart';

class DrawerChangeNotifier extends ChangeNotifier{
  static String productDesc = "product_desc";
  static String mainDesc = "main_desc";
  static String orderDesc ="order_desc";
  static String homeDashBord = "home_dashboard";
  static String settingDesc = "setting_desc";

  Widget _body = OrderDesc();
  Widget _productDescc;

  Widget get getBody => _body;

  void setBody(String s){
    switch(s){
      case "product_desc" : {
        // if(_productDescc == null){
        //   print("null");
        //   _productDescc = ProductDecs();
        // }
        _body = ProductDecs();
        notifyListeners();
        break;
      }
      case "main_desc" : {
        _body = HomeDashBord();
        notifyListeners();
        break;
      }
      case "order_desc": {
        _body = OrderDesc();
        notifyListeners();
        break;
      }
      case "home_dashboard":{
        _body = HomeDashBord();
        notifyListeners();
        break;
      }
      case "setting_desc" :{
        _body = SettingDesc();
        notifyListeners();
        break;
      }
    }
  }

}
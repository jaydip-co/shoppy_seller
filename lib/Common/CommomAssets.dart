import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonAssets {
  static Color appbacolor = Colors.white;
  static Color appbatextcolor = Colors.black;
  static Color buttontextcolor = Colors.white;

  // static Color shoppytitilecolor = Colors.green;
  static Color shoppytitilecolor = Color(0xff80CBC4);
  static Color appbardrawercolor = Colors.black;
  static Color shoppytitilecolor2 = Colors.green[300];
  static Color shoppyErrorColor = Colors.red[400];
  static Color denyButtonColor = Colors.red;

  //category
  static Color buttoncolor = Colors.white;
  static TextStyle ButtonText1 = TextStyle(
    color: CommonAssets.buttontextcolor,
  );



  static TextStyle Title1 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w300);
  static InputDecoration de = InputDecoration(
    fillColor: Colors.white,
    labelStyle: TextStyle(
      backgroundColor: Colors.green,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), bottomRight: Radius.circular(35)),
      borderSide: BorderSide(color: shoppytitilecolor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), bottomRight: Radius.circular(35)),
      borderSide: BorderSide(color: shoppytitilecolor),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), bottomRight: Radius.circular(35)),
      borderSide: BorderSide(color: shoppytitilecolor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), bottomRight: Radius.circular(35)),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), bottomRight: Radius.circular(35)),
      borderSide: BorderSide(color: Colors.red),
    ),
  );
}

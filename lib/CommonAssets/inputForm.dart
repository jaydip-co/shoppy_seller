import 'package:flutter/material.dart';
import 'package:shoppy_seller/Common/CommomAssets.dart';


InputDecoration inputdecoration =InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
          color: CommonAssets.shoppytitilecolor
      ),
    ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
        color: CommonAssets.shoppytitilecolor
    ),
  ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
          color: CommonAssets.shoppytitilecolor
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
          color: Colors.red
      ),
    ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
        color: Colors.red
    ),
  ),
);
// for other forms
InputDecoration inputforAppform =InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
          color: CommonAssets.shoppytitilecolor
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
          color: CommonAssets.shoppytitilecolor
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
          color: CommonAssets.shoppytitilecolor
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
          color: CommonAssets.shoppyErrorColor
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
          color: CommonAssets.shoppyErrorColor
      ),
    ),
    focusColor: CommonAssets.shoppytitilecolor,
    // labelStyle: TextStyle(
    //     color: Colors.black
    // )
);


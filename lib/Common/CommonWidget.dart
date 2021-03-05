import 'package:flutter/material.dart';

import 'CommomAssets.dart';

class CommonWidget{
    static RaisedButton getRaisedButton({String text,Function function,BuildContext context}){
      final height = MediaQuery.of(context).size.height;
    return RaisedButton(
      shape: StadiumBorder(),
      color: CommonAssets.shoppytitilecolor,
      onPressed: (){
        function();
      },

      child: Text(
        text,
        style: TextStyle(
            color: CommonAssets.buttontextcolor,
            fontSize: height *0.025
        ),
      ),
    );
  }
  static Widget CommonAppbar(Widget widget) {
    return PreferredSize(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: CommonAssets.shoppytitilecolor,
            offset: Offset(0, 2.0),
            blurRadius: 4.0,
          )
        ]),
        child: AppBar(

          iconTheme: IconThemeData(color: CommonAssets.appbardrawercolor),
          backgroundColor: CommonAssets.appbacolor,
          centerTitle: true,
          title: Text(
            'Shoppy',
            style: TextStyle(color: CommonAssets.shoppytitilecolor),
          ),
          actions: [
            widget
          ],
        ),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }
}
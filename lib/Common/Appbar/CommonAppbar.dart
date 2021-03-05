import 'package:flutter/material.dart';

import 'package:shoppy_seller/Common/CommomAssets.dart';



Widget CommonAppbar() {
  return PreferredSize(
    child: Container(
      // decoration: BoxDecoration(boxShadow: [
      //   BoxShadow(
      //     color: CommonAssets.shoppytitilecolor,
      //     offset: Offset(0, 2.0),
      //     blurRadius: 4.0,
      //   )
      // ]),
      child: AppBar(
        iconTheme: IconThemeData(color: CommonAssets.shoppytitilecolor),
        backgroundColor: CommonAssets.appbacolor,
        centerTitle: true,
        title: Text(
          'Shoppy',
          style: TextStyle(
              color: CommonAssets.shoppytitilecolor
          ),
        ),
      ),
    ),
    preferredSize: Size.fromHeight(kToolbarHeight),
  );
}
// AppBar(
// iconTheme: IconThemeData(color: CommonAssets.appbardrawercolor),
// backgroundColor: CommonAssets.appbacolor,
// centerTitle: true,
// title: Text('Shoppy',style: TextStyle(
// color: CommonAssets.shoppytitilecolor
// ),),
// );
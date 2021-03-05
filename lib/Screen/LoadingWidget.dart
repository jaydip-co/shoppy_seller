import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shoppy_seller/Common/CommomAssets.dart';
class LoadingVidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitDoubleBounce(color: CommonAssets.shoppytitilecolor,size: 50,),
    );
  }
}

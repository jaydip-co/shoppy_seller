import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy_seller/Common/Appbar/CommonAppbar.dart';
import 'package:shoppy_seller/Notifier/DrawerChangeNotifier.dart';
import 'package:shoppy_seller/Routes/RouteNames.dart';
import 'package:shoppy_seller/Screen/Home/Drawer.dart';
import 'package:shoppy_seller/Screen/Home/Widget/HomeDesk.dart';
import 'package:shoppy_seller/Screen/Home/Widget/ProductDesk.dart';
import 'package:shoppy_seller/Services/SellerFirebaseConfig.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final _drawerNotifier = Provider.of<DrawerChangeNotifier>(context);
    return Scaffold(
      appBar: CommonAppbar(),
      drawer: CommonDrawer(),
      body: _drawerNotifier.getBody,
      floatingActionButton: _drawerNotifier.getBody is ProductDecs ?
      FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, rAddItem);
        },
        child: Icon(Icons.add),
      )
          : Container(),

    );
  }
}

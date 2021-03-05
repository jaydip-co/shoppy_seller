import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy_seller/Routes/RouteNames.dart';
import 'package:shoppy_seller/Screen/AddItem.dart';
import 'package:shoppy_seller/Screen/Auth/Registration.dart';
import 'package:shoppy_seller/Screen/Auth/UserResistration.dart';
import 'package:shoppy_seller/Screen/EditItem/EditInventory.dart';
import 'file:///E:/jay/shoppy_seller/lib/Screen/Home/Widget/ProductDesk.dart';
import 'package:shoppy_seller/Screen/TestScreen.dart';
import 'package:shoppy_seller/Services/AuthService.dart';
import 'package:shoppy_seller/Services/DatabaseService.dart';
import 'package:shoppy_seller/Wrapper.dart';

import 'Common/CommomAssets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      Provider<AuthService>.value(value: AuthService()),
        Provider<DatabaseService>.value(value: DatabaseService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          accentColor: CommonAssets.shoppytitilecolor,
          // primarySwatch: CommonAssets.shoppytitilecolor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          rUserResistration : (c) => UserResistration(),
          rShopRegistration : (c) => ShopRegistration(),
          rAddItem :(c) => AddItem(),
        },
        home: Wrapper(),
      ),
    );
  }
}





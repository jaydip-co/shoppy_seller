import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shoppy_seller/Common/CommomAssets.dart';
import 'package:shoppy_seller/Notifier/DrawerChangeNotifier.dart';
import 'package:shoppy_seller/Screen/AddItem.dart';
import 'package:shoppy_seller/Screen/Auth/Registration.dart';
import 'package:shoppy_seller/Screen/Auth/UserResistration.dart';
import 'package:shoppy_seller/Screen/Home/Widget/HomDashBoard.dart';
import 'package:shoppy_seller/Screen/Home/Widget/HomeDesk.dart';

import 'package:shoppy_seller/Screen/SlashScreen.dart';

import 'package:shoppy_seller/Screen/TestScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppy_seller/Services/AuthService.dart';
import 'package:shoppy_seller/Services/DatabaseService.dart';
import 'package:shoppy_seller/Services/SellerFirebaseConfig.dart';





import 'Screen/Auth/LogIn.dart';
import 'Screen/Home/Home.dart';



class Wrapper extends StatefulWidget {
  @override
  //
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isLoadig = false;
  bool isFirstTime = false;
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<BottomNavigationProvider>.value(
    //     value: BottomNavigationProvider(),
    //     child: HomeScreen()
    // );
    DatabaseService _databseService = Provider.of<DatabaseService>(context,listen: false);
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,AsyncSnapshot<User> snapshot) {

        if(isFirstTime){
          return ShopRegistration();
        }
        if(snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        if(!snapshot.hasData || snapshot.data == null)
        {
          return Login();
        }
        else{
          print(snapshot.data.uid);
          return HomeWrapper(database: _databseService,);
          // setState(() {
          //   isLoadig = true;
          // });
          // DatabaseService(id: snapshot.data.uid).chechForShopRegistration().then((value) {
          //   if(value){
          //     setState(() {
          //       isLoadig = false;
          //       isFirstTime = true;
          //     });
          //   }
          // });
          // return MultiProvider(
          //   providers: [
          //     ChangeNotifierProvider<DrawerChangeNotifier>.value(value: DrawerChangeNotifier()),
          //   ],
          //   child: FutureBuilder<bool>(
          //     future: DatabaseService(id: snapshot.data.uid).chechForShopRegistration(),
          //     builder: (con,snap){
          //       if(!snap.hasData){
          //         return Center(child: SpinKitDoubleBounce(size: 50,color: CommonAssets.shoppytitilecolor,),);
          //       }
          //       print(snap.data);
          //       if(snap.data) {
          //         return ShopRegistration();
          //       }
          //       else{
          //         return Home();
          //       }
          //     },
          //   ),
          // );
          // return ChangeNotifierProvider<BottomNavigationProvider>.value(
          //     value: BottomNavigationProvider(),
          //     child: HomeScreen()
          // );
        }
      },
    );
  }
}

class HomeWrapper extends StatefulWidget {
  DatabaseService database;
  HomeWrapper({this.database});
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  bool isSlash = false;
  @override
  void initState() {

    super.initState();
    loadInitial();
  }
  loadInitial() async {
    setState(() {
      isSlash = true;
    });
    await widget.database.loadInitial();
   if(mounted){
     setState(() {
       isSlash = false;
     });
   }
  }
  @override
  Widget build(BuildContext context) {
    if(isSlash){
      return SplashScreen();
    }
    if(widget.database.model == null){
      return ShopRegistration();
    }
    return ChangeNotifierProvider<DrawerChangeNotifier>.value(
      value: DrawerChangeNotifier(),
        child: Home());
  }
}


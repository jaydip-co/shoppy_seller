import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppy_seller/Common/Appbar/CommonAppbar.dart';
import 'package:shoppy_seller/Common/CommomAssets.dart';
import 'package:shoppy_seller/Common/CommonWidget.dart';
import 'package:shoppy_seller/CommonAssets/inputForm.dart';
import 'package:shoppy_seller/Model/ShoModel.dart';
import 'package:shoppy_seller/Screen/LoadingWidget.dart';
import 'package:shoppy_seller/Services/AuthService.dart';
import 'package:shoppy_seller/Services/DatabaseService.dart';
import 'package:shoppy_seller/Utils/PrefIds.dart';
import 'package:shoppy_seller/Wrapper.dart';
import 'package:shoppy_seller/validator.dart';

class ShopRegistration extends StatefulWidget {
  @override
  _ShopRegistrationState createState() => _ShopRegistrationState();
}

class _ShopRegistrationState extends State<ShopRegistration> {
  ShopModel shopModel = ShopModel();

  int index = 0;

  Widget getBody() {
    switch (index) {
      case 0:
        return ShopDetail(
          function: () {
            index++;
            setState(() {});
          },
          model: shopModel,
        );
        break;
      case 1:
        return AddressDetail(
          continueFunction: () {
            index++;
            setState(() {});
          },
          backFunction: () {
            index--;
            setState(() {});
          },
          model: shopModel,
        );
        break;
      case 2:
        return AccountDetail(
          backFunction: () {
            index--;
            setState(() {});
          },
          model: shopModel,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppbar(), body: getBody());
  }
}

class ShopDetail extends StatefulWidget {
  Function function;
  ShopModel model;

  ShopDetail({this.function, this.model});

  @override
  _ShopDetailState createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  final key = GlobalKey<FormState>();
  String shopName;
  String sellerName;
  int mobileNumber;
  String email;
  String shopType;
  bool isLoading;
  List<Widget> shopCategoryList = [];

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchCategor();
  }

  Future askForPermision() async {
    print("other");
    if (await Permission.location.request().isGranted) {
      print("granted");
      widget.function();
    }
    final p = Permission.location.status;
    if (await p.isUndetermined || await p.isDenied) {}
    print("other");
  }

  Future fetchCategor() async {
    final reg = await FirebaseFirestore.instance
        .collection("shopType")
        .doc("type")
        .get();
    await Future.delayed(Duration(seconds: 1));
    if (reg.data() != null) {
      final data = reg.data();
      List<String> list = List.from(data["categories"]);
      shopCategoryList = list
          .map((e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              ))
          .toList();
      isLoading = false;
      setState(() {});
    } else {
      print("data");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isLoading
        ? Center(
            child: SpinKitDoubleBounce(
              size: 50,
              color: CommonAssets.shoppytitilecolor,
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 16.0, right: 15.0),
            child: Form(
              key: key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      "asset/user.png",
                      height: 300,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Shop Details", style: CommonAssets.Title1),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: CommonAssets.de.copyWith(
                        hintText: "Name ",
                      ),
                      onChanged: (val) => sellerName = val,
                      validator: (val) =>
                          val.isEmpty ? "Enter your name" : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: CommonAssets.de.copyWith(
                        hintText: "Shop Name",
                      ),
                      onChanged: (val) => shopName = val,
                      validator: (val) =>
                          val.isEmpty ? "Enter Shop Name" : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: CommonAssets.de.copyWith(
                        hintText: "Mobile Number",
                      ),
                      onChanged: (val) => mobileNumber = int.parse(val),
                      validator: validator.varifyMobile,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: CommonAssets.de.copyWith(
                        hintText: "Email ",
                      ),
                      validator: validator.ValidateEmail,
                      onChanged: (val) => email = val,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField(
                      hint: Text("Category"),
                      decoration: CommonAssets.de,
                      validator: (val) =>
                          val == null ? "Select Category" : null,
                      onChanged: (val) {
                        shopType = val;
                      },

                      ///TODO : attach category
                      items: shopCategoryList,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            disabledElevation: 0,
                            elevation: 2,
                            shape: StadiumBorder(),
                            color: CommonAssets.shoppytitilecolor,
                            onPressed: () async {
                              Provider.of<AuthService>(context, listen: false)
                                  .SignOut();
                            },
                            child: Text('Logout',
                                style: CommonAssets.ButtonText1.copyWith(
                                    fontSize: size.height * 0.025)),
                          ),
                          RaisedButton(
                            disabledElevation: 0,
                            elevation: 2,
                            shape: StadiumBorder(),
                            color: CommonAssets.shoppytitilecolor,
                            onPressed: () async {
                              if (key.currentState.validate()) {
                                widget.model.sellerName = sellerName;
                                widget.model.shopName = shopName;
                                widget.model.mobileNo = mobileNumber;
                                widget.model.emailId = email;
                                widget.model.shopType = shopType;
                                SharedPreferences _prefs =
                                    await SharedPreferences.getInstance();
                                final b =
                                    await _prefs.setString(SHOP_TYPE, shopType);
                                print(b);
                                askForPermision();
                              }
                            },
                            child: Text('Continue',
                                style: CommonAssets.ButtonText1.copyWith(
                                    fontSize: size.height * 0.025)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class AddressDetail extends StatefulWidget {
  Function continueFunction;
  Function backFunction;
  ShopModel model;

  AddressDetail({this.backFunction, this.continueFunction, this.model});

  @override
  _AddressDetailState createState() => _AddressDetailState();
}

class _AddressDetailState extends State<AddressDetail> {
  final key = GlobalKey<FormState>();
  String shopNo;
  String complexName;
  String landmark;
  String city = "";
  int pincode = 0;
  String state;
  String county;
  bool isLoading = false;

  Future askForPermision() async {
    print("other");
    if (await Permission.location.request().isGranted) {
      print("granted");
    }
    final p = Permission.location.status;
    if (await p.isUndetermined || await p.isDenied) {}
    print("other");
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permantly denied, we cannot request permissions.');
    // }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  void setInitilData() async {
    setState(() {
      isLoading = true;
    });
    final position = await _determinePosition();
    List<Placemark> plcasemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (plcasemarks.isNotEmpty) {
      try {
        Placemark placemark = plcasemarks[0];
        // for(Placemark placemark in plcasemarks) {
        //   print(placemark.locality + "/////" +plcasemarks.indexOf(placemark).toString());
        //   print(placemark.name);
        // }
        widget.model.longitute = position.longitude;
        widget.model.latitute = position.latitude;
        setState(() {
          state = placemark.administrativeArea;

          county = placemark.country;
          pincode = int.parse(placemark.postalCode);
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setInitilData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (isLoading) {
      return LoadingVidget();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
      child: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "asset/address.png",
                height: 300,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Address Details",
                style: CommonAssets.Title1,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: CommonAssets.de.copyWith(
                  hintText: "Shop no. ",
                ),
                onChanged: (val) => shopNo = val,
                validator: (val) => val.isEmpty ? "Enter shop no." : null,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: CommonAssets.de.copyWith(
                  hintText: "Complex Name ",
                ),
                onChanged: (val) => complexName = val,
                validator: (val) =>
                    val.isEmpty ? "Enter Complex name or society name" : null,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: landmark,
                decoration: CommonAssets.de.copyWith(
                  hintText: "Landmark",
                ),
                validator: (val) => val.isEmpty ? "Enter landmark." : null,
                onChanged: (val) => landmark = val,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: city,
                      decoration: CommonAssets.de.copyWith(
                        hintText: "City ",
                      ),
                      validator: (val) => val.isEmpty ? "Enter city." : null,
                      onChanged: (val) => city = val,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: pincode.toString(),
                      decoration: CommonAssets.de.copyWith(
                        hintText: "Pincode",
                      ),
                      keyboardType: TextInputType.number,
                      validator: validator.varifyPincode,
                      onChanged: (val) => pincode = int.parse(val),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: state,
                      decoration: CommonAssets.de.copyWith(
                        hintText: "State ",
                      ),
                      validator: (val) => val.isEmpty ? "Enter state." : null,
                      onChanged: (val) => state = val,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: county,
                      decoration: CommonAssets.de.copyWith(
                        hintText: "Country ",
                      ),
                      validator: (val) => val.isEmpty ? "Enter country." : null,
                      onChanged: (val) => county = val,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    disabledElevation: 0,
                    elevation: 2,
                    shape: StadiumBorder(),
                    color: CommonAssets.shoppytitilecolor,
                    onPressed: () {
                      widget.backFunction();
                    },
                    child: Text('Back',
                        style: CommonAssets.ButtonText1.copyWith(
                            fontSize: size.height * 0.025)),
                  ),
                  RaisedButton(
                    disabledElevation: 0,
                    elevation: 2,
                    shape: StadiumBorder(),
                    color: CommonAssets.shoppytitilecolor,
                    onPressed: () {
                      if (key.currentState.validate()) {
                        widget.model.shopNo = shopNo;
                        widget.model.ComplexName = complexName;
                        widget.model.landmark = landmark;
                        widget.model.city = city;
                        widget.model.pincode = pincode;
                        widget.model.state = state;
                        widget.model.country = county;
                        widget.continueFunction();
                      }
                    },
                    child: Text('Continue',
                        style: CommonAssets.ButtonText1.copyWith(
                            fontSize: size.height * 0.025)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountDetail extends StatefulWidget {
  Function backFunction;
  ShopModel model;

  AccountDetail({this.backFunction, this.model});

  @override
  _AccountDetailState createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final key = GlobalKey<FormState>();
  String accountName;
  int accountNumber;
  String ifscCode;
  bool onlyOffLinePayment = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final s = SizedBox(
      height: size.height * 0.02,
    );
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
      child: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "asset/account.png",
                height: 300,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "UPI Details",
                style: CommonAssets.Title1,
              ),
              s,
              if (!onlyOffLinePayment) TextFormField(
                decoration: CommonAssets.de.copyWith(
                  hintText: "example@upi",
                ),
                validator: (val) => val.isEmpty ? "Enter UPI ID" : null,
                enabled: !onlyOffLinePayment,
                onChanged:   (val) => accountName = val,
              ),
              // s,
              // TextFormField(
              //   decoration:CommonAssets.de.copyWith(hintText:"Account Number ",),
              //   validator: validator.numbervalidtion,
              //   keyboardType: TextInputType.number,
              //   onChanged: (val) => accountNumber = int.parse(val),
              // ),
              // s,
              // TextFormField(
              //   decoration:CommonAssets.de.copyWith(hintText:"IFSC Code ",),
              //   validator: (val) => val.isEmpty ? "Enter IFSC Code" : null,
              //   onChanged: (val) => ifscCode = val,
              // ),
              s,
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      onlyOffLinePayment = !onlyOffLinePayment;
                    });
                  },
                  child: Row(
                    children: [
                      Checkbox(
                       value: onlyOffLinePayment,
                        onChanged: (val) {
                          setState(() {
                            onlyOffLinePayment = val;
                          });
                        },

                      ),
                      Text("Accept only Offline payment"),
                    ],
                  ),
                ),
              ),
              s,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    disabledElevation: 0,
                    elevation: 2,
                    shape: StadiumBorder(),
                    color: Colors.grey,
                    onPressed: () {
                      // if(_formkey.currentState.validate()){
                      //
                      // }
                      widget.backFunction();
                    },
                    child: Text('Back',
                        style: CommonAssets.ButtonText1.copyWith(
                            fontSize: size.height * 0.025)),
                  ),
                  CommonWidget.getRaisedButton(
                      text: "Save",
                      function: () async {
                        if(!onlyOffLinePayment) {
                          if (key.currentState.validate()) {
                            widget.model.accountname = accountName;
                            DatabaseService service =
                            Provider.of<DatabaseService>(context,
                                listen: false);
                            await service.setShopData(widget.model);
                            // await DatabaseService().setShopData(widget.model);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (co) => Wrapper()));
                            print("done");
                          }
                        }
                        else{
                          DatabaseService service =
                          Provider.of<DatabaseService>(context,
                              listen: false);
                          await service.setShopData(widget.model);
                          // await DatabaseService().setShopData(widget.model);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (co) => Wrapper()));
                          print("done");
                        }

                      },
                      context: context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

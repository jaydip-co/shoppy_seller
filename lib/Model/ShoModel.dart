

import 'package:shoppy_seller/Services/SellerFirebaseConfig.dart';

class ShopModel{
  String sellerName;
  String shopName;
  int mobileNo;
  String emailId;
  String shopNo;
  String ComplexName;
  String landmark;
  String shopType;
  String city;
  int pincode;
  String state;
  String country;
  String accountname;
  double latitute;
  double longitute;
  List<String> products;
  List<String> orders;
  ShopModel({this.sellerName,this.shopName,this.mobileNo,this.emailId,this.shopNo,
  this.ComplexName,this.landmark,this.city,this.pincode,this.state,this.country,
  this.accountname,this.shopType,this.latitute,this.longitute,
  this.products,this.orders});
 factory ShopModel.from(Map<String,dynamic> map){
    return ShopModel(
      sellerName: map[sSellerName],
      shopName: map[sShopName],
      mobileNo: map[sMobile_Number],
      emailId: map[sEmail_id],
      products: List.from(map[sProduct]).map((e) => e.toString()).toList(),
      shopType: map[sShopType],
      shopNo: map[sShopNo],
      ComplexName: map[sComplexName],
      landmark: map[sLandmark],
      city: map[sCity],
      state: map[sState],
      country: map[sCountry],
      orders: List.from(map[sOrders]).map((e) => e.toString()).toList(),
    );
  }

  @override
  String toString() {
    return 'ShopModel{sellerName: $sellerName, shopName: $shopName, mobileNo: $mobileNo, emailId: $emailId, shopNo: $shopNo, ComplexName: $ComplexName, landmark: $landmark, shopType: $shopType, city: $city, pincode: $pincode, state: $state, country: $country, accountname: $accountname, latitute: $latitute, longitute: $longitute, products: $products}';
  }
}


import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppy_seller/Model/ItemModel.dart';
import 'package:shoppy_seller/Model/OrderModel.dart';
import 'package:shoppy_seller/Model/ShoModel.dart';
import 'package:shoppy_seller/Services/ItemFirebaseConfig.dart';
import 'package:shoppy_seller/Services/SellerFirebaseConfig.dart';
import 'package:shoppy_seller/Utils/PrefIds.dart';

class DatabaseService{
  ShopModel model;
  String id;
  CollectionReference  _refItem ;
  final _refSeller = FirebaseFirestore.instance.collection("Seller");
  final _orderRefs = FirebaseFirestore.instance.collection("AllOrders");
  DatabaseService({this.id});
  List<ItemModel> inventoryItem = [];
  List<OrderModel> orders = [];
  List<OrderModel> confirmedOrders = [];

  ////Stremas ........................////////////////

  StreamController<List<ItemModel>> _itemController = BehaviorSubject<List<ItemModel>>();

  Stream<List<ItemModel>> get getItems{
    if(inventoryItem.isEmpty){
      refreshList();
    }
   return _itemController.stream;
  }
  StreamController<List<OrderModel>> _ordersController = BehaviorSubject<List<OrderModel>>();
  Stream<List<OrderModel>> get getOrders => _ordersController.stream;
  StreamController<List<OrderModel>> _confirmedOrder = BehaviorSubject<List<OrderModel>>();
  Stream<List<OrderModel>> get getConfirmedOrders => _confirmedOrder.stream;
  StreamController<List<OrderModel>> _cancelOrder = BehaviorSubject<List<OrderModel>>();
  Stream<List<OrderModel>> get getCancelOrders => _cancelOrder.stream;
  StreamController<List<OrderModel>> _deliveredOrder = BehaviorSubject<List<OrderModel>>();
  Stream<List<OrderModel>> get getDeliveredOrders => _deliveredOrder.stream;

  void dispose(){
    _itemController.close();
    _ordersController.close();
    _confirmedOrder.close();
    _cancelOrder.close();
    _deliveredOrder.close();
  }

  Future loadInitial() async{
    id = FirebaseAuth.instance.currentUser.uid;
    final doc = await _refSeller.doc(id).get();
    if(doc.data() != null){
       model  = ShopModel.from(doc.data());
       _refItem = FirebaseFirestore.instance.collection(model.shopType);
      print(model.toString());
       if(model.orders.length > 0){
         // print(model.orders.length.toString() + "length of order" );
         for(String s in model.orders){
           final orderDoc  = await _orderRefs.doc(s).get();
           OrderModel temp = OrderModel.of(orderDoc.data());
           temp.orderId = s;
           orders.add(temp);
         }
         _ordersController.sink.add(orders);
       }
    }



  }




  ///////////////////Methods For Custom Streams //////////////////////////////

  void refreshList(){
    _refSeller.doc(id).get().then((value) async {
      if(value.exists){
        final _listRef = List.from(value.data()[sProduct]).map((e) => e as DocumentReference).toList();
        print(_listRef.length.toString() + " count from data");
        if(_listRef.length > 0){
          print("entered");
          inventoryItem = [];
          for(DocumentReference ref in _listRef){
            final d = await ref.get();
            ItemModel model = ItemModel.of(d.data());
            inventoryItem.add(model);
          }
          // _listRef.map((e) {
          //   print(e);
          //   // final d = await e.get();
          //   // print(d.data());
          //   // ItemModel model = ItemModel.of(d.data());
          //   // inventoryItem.add(model);
          // });


        }
        print(inventoryItem.length.toString() + " count from items");
        _itemController.sink.add(inventoryItem);
      }
    });
  }









  /////////////////////////Methods For Database Store//////////////////////////
  Future SaveNewItem(ItemModel itemModel) async {
    final date = DateTime.now();
    String procutId = getUniqueProdctId();
    final res = uploadItem(itemModel.imagesToUpload ,procutId);
    final reftoStore = _refItem.doc(procutId);
   await  reftoStore.set({
      iProductName : itemModel.productName ?? "",
      iDescription : itemModel.description ?? "",
      iProductType : itemModel.productType ?? "",
      iAvailableQuantity : itemModel.availableQuantity ?? 0,
      iMRP : itemModel.mrp ?? 0,
      iSellingPrice : itemModel.sellingPrice ?? 0,
      iUnit : itemModel.unit ?? "KG",
      iKeywords : itemModel.keyWords ?? [],
      iImages : await res,
     iProductCode : itemModel.productCode,
     iRefId : procutId,
     iQuantityAsPrice : itemModel.quantityAsPrice,
     iSellerId : id,
     iShopName : model.shopName,
     iSellingType : itemModel.sellingType,
    });

   await _refSeller.doc(id).update({
     sProduct : FieldValue.arrayUnion([reftoStore]),
   });
   await _refSeller.doc(id).update({
     sProductCode : FieldValue.arrayUnion([itemModel.productCode]),
   });


    
  }

  Future confirmOrder(OrderModel model)async{
    DocumentReference  reference = _orderRefs.doc(model.orderId);
    await  _refSeller.doc(id).update({
      sConfirmOrders : FieldValue.arrayUnion([reference]),
    });
    orders.remove(model);
    confirmedOrders.add(model);
    _ordersController.sink.add(orders);
    _confirmedOrder.sink.add(confirmedOrders);
  }

  Future cancelOrder(OrderModel  model) async{
    DocumentReference reference = _orderRefs.doc(model.orderId);
    await _refSeller.doc(id).update({
      sCancelOrders : FieldValue.arrayUnion([reference]),
      sOrders : FieldValue.arrayRemove([reference.id.toString()]),
    }
    );
  }
  Future UplateInventory(ItemModel itemModel){
    _refItem.doc(itemModel.refId).update({
      iDescription : itemModel.description ?? "",
      iAvailableQuantity : itemModel.availableQuantity ?? 0,
      iMRP : itemModel.mrp ?? 0,
      iSellingPrice : itemModel.sellingPrice ?? 0,
      iUnit : itemModel.unit ?? "",
    });
  }
  Future<bool> isCodeAlredyUsed(String s) async{
    final doc = await _refSeller.doc(id).get();
    print(id);
    final codes = List.of(doc.data()[sProductCode]).map((e) => e.toString()).toList();
    if(codes.contains(s.toUpperCase())){
      return true;
    }
    return false;
  }
  Future<bool> chechForShopRegistration() async {
    final doc = await _refSeller.doc(id).get();
    if(doc.data() == null){
      print("yes");
      return true;
    }
    return false;
  }
  ///TODO : change Static id to class id
  Future setShopData(ShopModel model) async {
    _setShopType(model.shopType);
    return await _refSeller.doc(id).set({
      sSellerName : model.sellerName,
      sShopName : model.shopName,
      sMobile_Number : model.mobileNo,
      sEmail_id : model.emailId,
      sShopNo : model.shopNo,
      sComplexName : model.ComplexName,
      sLandmark : model.landmark,
      sCity : model.city,
      sPincode : model.pincode,
      sState : model.state,
      sCountry : model.country,
      sAccountName : model.accountname,
      sShopType : model.shopType,
      sProduct : [],
      sProductCode : [],
      sShopGeoPoint : GeoPoint(model.latitute,model.longitute),
      sSeller_Id : id,
      sOrders : [],
    });
  }

  String getUniqueProdctId(){
    final date = DateTime.now();
    return "PRDT_"+date.day.toString()+":"+date.month.toString()+":"+date.year.toString()+":"+date.hour.toString()+":"+
        date.minute.toString()+":"+date.second.toString()+":"+date.millisecond.toString()+":"+date.microsecond.toString();
  }
  Future<List<String>> uploadItem(List<File> files,String id) async {
    firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance.ref("Products").child(id);
    List<String> urls = [];
    for(File f in files){
      print(f.path);
      final res = await reference.child("image"+files.indexOf(f).toString()).putFile(f);
      urls.add(await res.ref.getDownloadURL());
      print(files.indexOf(f).toString() + "   /////   "+await res.ref.getDownloadURL());

    }
    return urls;
  }
   Future _setShopType(String type) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(SHOP_TYPE,type);
  }
  Future<List<String>> getProductTypes() async {
    String type = model.shopType;
    print(type+"Type");
    final list = await FirebaseFirestore.instance.collection("ProductType").doc(type+"Type").get();
    List<String> strings = List.of(list["type"]).map((e) => e.toString()).toList();
    return strings;
  }
}
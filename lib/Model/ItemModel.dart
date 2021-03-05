import 'dart:io';

import 'package:shoppy_seller/Services/ItemFirebaseConfig.dart';

class ItemModel{
  List<File> imagesToUpload;
  String productCode;
  String productName;
  String description;
  String unit;
  String sellingType;
  int availableQuantity;
  int mrp;
  int sellingPrice;
  String productType;
  List<String> keyWords;
  List<String> urls;
  String refId;
  int quantityAsPrice;
  ItemModel({this.imagesToUpload,this.productName,this.description,this.unit,
    this.availableQuantity,this.keyWords,this.mrp,this.productType,this.sellingPrice,
  this.productCode,this.urls,this.refId,this.quantityAsPrice,this.sellingType});

  factory ItemModel.of(Map<String,dynamic> map){
    return ItemModel(
      urls: List.of(map[iImages]).map((e) => e.toString()).toList(),
      productName: map[iProductName],
      productType: map[iProductType],
      sellingPrice: map[iSellingPrice],
      productCode: map[iProductCode],
      description: map[iDescription],
      unit: map[iUnit],
      availableQuantity: map[iAvailableQuantity],
      mrp: map[iMRP],
      quantityAsPrice: map[iQuantityAsPrice],
      sellingType: map[iSellingType],
    );
  }

}
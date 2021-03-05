

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shoppy_seller/Services/ItemFirebaseConfig.dart';
import 'package:shoppy_seller/Services/OrderFirebaseConfig.dart';

class OrderModel {
  String shopName;
  String productName;
  String customerName;
  String customerId;
  String sellerId;
  DocumentReference refId;
  String status;
  String expectedTime;
  String reasonForCancel;
  String orderTime;
  String deliveryTime;
  String deliveryAddress;
  double quantity;
  String unit;
  double amount;
  String orderId;


  OrderModel({
    this.shopName,
    this.customerName,
    this.customerId,
    this.sellerId,
    this.refId,
    this.status,
    this.expectedTime,
    this.reasonForCancel,
    this.orderTime,
    this.deliveryTime,
    this.deliveryAddress,
    this.quantity,
    this.unit,
    this.amount,
    this.productName});

factory OrderModel.of(Map<String,dynamic> maps){
  return OrderModel(
    customerId: maps[oCustomerId],
    customerName: maps[oCustomerName],
    refId: maps[oProductId] as DocumentReference,
    status: maps[oStatus],
    deliveryAddress: maps[oDeliveryAddress],
    orderTime: maps[oOrderTime],
    productName: maps[oProductName],
    quantity: maps[oQuantity],
    unit: maps[oUnit],
    amount: maps[oAmount],
  );

}

}
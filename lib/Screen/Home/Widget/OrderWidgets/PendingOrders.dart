import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy_seller/Common/CommomAssets.dart';
import 'package:shoppy_seller/Model/OrderModel.dart';
import 'package:shoppy_seller/Screen/LoadingWidget.dart';
import 'package:shoppy_seller/Services/DatabaseService.dart';

class PendingOrder extends StatefulWidget {
  @override
  _PendingOrderState createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double fontsize = 14;
    double maxfontsize = 12;
    final database = Provider.of<DatabaseService>(context);
    return Container(
      child: StreamBuilder<List<OrderModel>>(
        stream: database.getOrders,
        builder: (con,data) {
          if(!data.hasData){
            return LoadingVidget();
          }
          List<OrderModel> orders = data.data;
          return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (con,i) {
                return  GestureDetector(
                  onTap: (){
                    ontapOrder(size,orders[i],database);
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: CommonAssets.shoppytitilecolor),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("asset/Icon.jpg",height: size.height * 0.2,),
                          // Image.network("asset/Icon.jpg",height: size.height * 0.2,),
                          SizedBox(width: size.width * 0.02,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,


                              children: [
                                SizedBox(height: size.height *0.01,),

                                AutoSizeText(
                                  orders[i].productName,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  ),
                                  minFontSize: 15,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: size.height *0.01,),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      'Product Id:',
                                      style: TextStyle(
                                          fontSize: fontsize,
                                          fontWeight: FontWeight.bold
                                      ),
                                      minFontSize: maxfontsize,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Expanded(child: AutoSizeText(
                                      'SKU CODE',
                                      style: TextStyle(
                                        fontSize: fontsize,

                                      ),
                                      minFontSize: maxfontsize,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),)
                                  ],
                                ),
                                SizedBox(height: size.height *0.005,),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      'Order Id:',
                                      style: TextStyle(
                                          fontSize: fontsize,
                                          fontWeight: FontWeight.bold
                                      ),
                                      minFontSize: maxfontsize,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Expanded(child: AutoSizeText(
                                      orders[i].orderId,
                                      style: TextStyle(
                                        fontSize: fontsize,

                                      ),
                                      minFontSize: maxfontsize,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),)
                                  ],
                                ),
                                SizedBox(height: size.height *0.005,),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      'Dispatch Date:',
                                      style: TextStyle(
                                          fontSize: fontsize,
                                          fontWeight: FontWeight.bold
                                      ),
                                      minFontSize: maxfontsize,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Expanded(child: AutoSizeText(
                                      '19-12-1999',
                                      style: TextStyle(
                                        fontSize: fontsize,

                                      ),
                                      minFontSize: maxfontsize,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),)
                                  ],
                                ),
                                SizedBox(height: size.height *0.005,),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      'QTY:',
                                      style: TextStyle(
                                          fontSize: fontsize,
                                          fontWeight: FontWeight.bold
                                      ),
                                      minFontSize: maxfontsize,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Expanded(child: AutoSizeText(
                                      orders[i].quantity.toString(),
                                      style: TextStyle(
                                        fontSize: fontsize,

                                      ),
                                      minFontSize: maxfontsize,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                  ),
                );
              });
        },
      ),
    );
  }
  Widget ontapOrder(Size size,OrderModel model,DatabaseService database) {
    double fontsize = 14;
    double maxfontsize = 12;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(30.0)),
            scrollable: true,
            title: Text('Add Product Name'),
            content: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Product:',
                          style: TextStyle(
                              fontSize: fontsize, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          model.productName,
                          style: TextStyle(
                            fontSize: fontsize,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Product Id:',
                          style: TextStyle(
                              fontSize: fontsize, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "model.refId.toString()",
                          style: TextStyle(
                            fontSize: fontsize,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'QTY:',
                          style: TextStyle(
                              fontSize: fontsize, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          model.quantity.toString(),
                          style: TextStyle(
                            fontSize: fontsize,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Product Price:',
                          style: TextStyle(
                              fontSize: fontsize, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          model.amount.toString(),
                          style: TextStyle(
                            fontSize: fontsize,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Status:',
                          style: TextStyle(
                              fontSize: fontsize, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          model.status,
                          style: TextStyle(
                            fontSize: fontsize,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    thickness: 2,
                  ),
                  Text(
                    'Address Details',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Container(
                    width: size.width * 0.5,
                    child: Text(
                      model.deliveryAddress,
                      maxLines: 4,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                ],
              ),
            ),
            actions: [
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: CommonAssets.denyButtonColor)),
                onPressed: () {},
                child: Text('Deny'),
              ),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                onPressed: () {
                  database.confirmOrder(model);
                  Navigator.pop(context);
                },
                child: Text('Accept'),
              )
            ],
          );
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:shoppy_seller/Common/Appbar/CommonAppbar.dart';
import 'package:shoppy_seller/Common/CommomAssets.dart';
import 'package:shoppy_seller/Model/OrderModel.dart';
import 'package:shoppy_seller/Screen/Home/Widget/OrderWidgets/CancleOrder.dart';
import 'package:shoppy_seller/Screen/Home/Widget/OrderWidgets/ConfirmedOrder.dart';
import 'package:shoppy_seller/Screen/Home/Widget/OrderWidgets/DeliveredOreder.dart';
import 'package:shoppy_seller/Screen/Home/Widget/OrderWidgets/PendingOrders.dart';
import 'package:shoppy_seller/Screen/LoadingWidget.dart';
import 'package:shoppy_seller/Services/DatabaseService.dart';
import 'package:shoppy_seller/Services/LocalData.dart';

class OrderDesc extends StatefulWidget {
  @override
  _OrderDescState createState() => _OrderDescState();
}

class _OrderDescState extends State<OrderDesc> {
  int ButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double fontsize = 14;
    double maxfontsize = 12;
    List<String> buttonTitle = LocalData.OrderState;
    final database = Provider.of<DatabaseService>(context);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.06,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: buttonTitle.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: index != ButtonIndex
                                    ? Colors.grey
                                    : CommonAssets.shoppytitilecolor)),
                        onPressed: () {
                          print("pressed");
                          setState(() {
                            ButtonIndex = index;
                            print(ButtonIndex.toString());
                          });
                        },
                        child: Text(buttonTitle[index].toString()),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          // Text("jay"),
          Expanded(
            child: getOrderWidget(),
          ),
        ],
      ),
    );
  }
  Widget getOrderWidget(){
    switch(ButtonIndex){
      case 0: {
        return PendingOrder();
      }
      case 1 :
        return ConfirmedOrder();
      case 2 :
        return DeliveredOrder();
      case 3 :
        return CancelOrder();
      default :
        return PendingOrder();
    }

  }


}

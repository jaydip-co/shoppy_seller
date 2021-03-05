import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy_seller/Common/CommomAssets.dart';
import 'package:shoppy_seller/Model/ItemModel.dart';
import 'package:shoppy_seller/Routes/RouteNames.dart';
import 'package:shoppy_seller/Screen/EditItem/EditInventory.dart';
import 'package:shoppy_seller/Screen/LoadingWidget.dart';
import 'package:shoppy_seller/Screen/TestScreen.dart';
import 'package:shoppy_seller/Services/DatabaseService.dart';
class ProductDecs extends StatefulWidget {
  @override
  _ProductDecsState createState() => _ProductDecsState();
}

class _ProductDecsState extends State<ProductDecs> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setLoading();

  }
  setLoading()async{
    await Future.delayed(Duration(seconds: 1));
    isLoading = false;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final _databaseSerive = Provider.of<DatabaseService>(context,listen: false);
    if(isLoading){
      return LoadingVidget();
    }

    return  RefreshIndicator(
      onRefresh: (){
        print("refress");
        _databaseSerive.refreshList();
        return Future.delayed(Duration(seconds: 1));
      },
      child: StreamBuilder<List<ItemModel>>(
        stream: _databaseSerive.getItems,
          builder: (con,snap){
            if(snap.hasData) {
              if(snap.data.length == 0){
                return   Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text("No Item in Inventory")));
              }
              return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (con, index) {
                    final data = snap.data[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: CommonAssets.shoppytitilecolor),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              // child: Image.asset("asset/Icon.jpg",height: height * 0.15,),
                              child: Container(
                                height: height * 0.15,
                                  width: width * 0.20,
                                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage("asset/Icon.jpg"))),
                                  child: Image.network(snap.data[index].urls[0],fit: BoxFit.cover,)),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: height * 0.01,),
                                Container(
                                  width: width * 0.5,
                                  child: Text(
                                    data.productName
                                    // "Super One"
                                    , style: TextStyle(
                                      fontSize: width * 0.05),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,

                                  ),
                                ),
                                SizedBox(height: height * 0.01,),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [

                                        Text("Code"),
                                        Text("Type"),
                                        Text("Price"),
                                        Text("available"),

                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [

                                        Text(" : "),
                                        Text(" : "),
                                        Text(" : "),
                                        Text(" : "),

                                      ],
                                    ),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(data.productCode ?? "jay"),
                                        Text(data.productType),
                                        Text(data.sellingPrice.toString()),
                                        Text("yes"),

                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (con) => EditInventory(model: data)));
                                }, child: Text("Update \n Inventory",textAlign: TextAlign.center
                                  ,
                                style: TextStyle(
                                  fontSize: height * 0.02,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600
                                ),))
                              ],
                              // children: [
                              //
                              //   GestureDetector(
                              //     onTap: (){
                              //       Navigator.push(context, MaterialPageRoute(builder: (con) => EditInventory(model: data)));
                              //     },
                              //       child: Icon(Icons.update)),
                              //
                              // ],
                            ),
                            SizedBox(width: width * 0.03,)
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
            else {
              print("count 0");
              return LoadingVidget();
            }
          }),
    );
  }
}


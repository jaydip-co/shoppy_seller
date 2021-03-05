import 'package:flutter/material.dart';
import 'package:shoppy_seller/Common/Appbar/CommonAppbar.dart';
import 'package:shoppy_seller/Screen/AddItem.dart';
import 'package:shoppy_seller/Screen/Home/Drawer.dart';
class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: CommonDrawer(),
      // appBar: CommonAppbar(),
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (c)=> AddItem()));
        },
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * .3,
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.red
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 20,bottom: 20),
                    child: Text("Medicine",style: TextStyle(color: Colors.white,fontSize: size.width * 0.08),),
                  ),
                  Container(
                    height: size.height * .85,
                    width: size.width * 0.95,
                    child: GridView.count(

                      crossAxisCount: 2,
                      childAspectRatio: size.height * .0008,
                      children: [
                        for(int i=0;i<20;i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: size.height * 0.01,),
                                  Image.asset("asset/Icon.jpg",height: size.height * 0.15,),
                                  SizedBox(height: size.height * 0.01,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(width: size.width * 0.01,),
                                      Text("price : ",style: TextStyle(
                                        fontSize: size.width * 0.04
                                      ),),
                                      SizedBox(width: size.width * 0.01,),
                                      Text("200",style: TextStyle(
                                        fontSize: size.width * 0.06
                                      ),),
                                      SizedBox(width: size.width * 0.01,),
                                      Text("350",style: TextStyle(
                                        color: Colors.red,
                                          fontWeight: FontWeight.w300,
                                          decoration: TextDecoration.lineThrough,
                                          fontStyle: FontStyle.italic,
                                          fontSize: size.width * 0.04
                                      ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      Icon(Icons.shopping_cart),
                                      Icon(Icons.shopping_bag_rounded)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          ],
                        ),
                  ),
                ],
              ),
            ),
          )

        ],
      )
    );
  }
}

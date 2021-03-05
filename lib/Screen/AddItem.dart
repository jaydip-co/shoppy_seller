
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shoppy_seller/Common/Appbar/CommonAppbar.dart';
import 'package:shoppy_seller/Common/CommomAssets.dart';
import 'package:shoppy_seller/CommonAssets/inputForm.dart';
import 'package:shoppy_seller/Model/ItemModel.dart';
import 'package:shoppy_seller/Screen/Home/Drawer.dart';
import 'package:shoppy_seller/Screen/LoadingWidget.dart';
import 'package:shoppy_seller/Services/DatabaseService.dart';
import 'package:shoppy_seller/Services/ItemFirebaseConfig.dart';
import 'package:shoppy_seller/Services/LocalData.dart';


class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  ItemModel itemModel = ItemModel();

  int index = 0;



  Widget getBody(DatabaseService service){
    switch(index){
      case 0:
        return AddTypeAndCode(
          databaseService: service,
          model: itemModel,
            continueFunction: (){
          index++;
          setState(() {

          });
            },);
      case 1:
        return AddImage(function: (){
          index ++;
          setState(() {

          });
        },
          model: itemModel,
        );
        break;
      case 2:
        return AddDetail(
          backFunction: (){
            index--;
            setState(() {

            });
          },
          savFunction: (){
            //TODO : implement save
          },
          model: itemModel,
        );
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    final _database = Provider.of<DatabaseService>(context);
    return Scaffold(
      appBar: CommonAppbar(),
      body: getBody(_database),
    );
  }
  String numbervalidtion(String value){
    Pattern pattern = '^[0-9]+';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter The Number Only';
    } else {
      return null;
    }
  }
}
class AddTypeAndCode extends StatefulWidget {
  ItemModel model;
  Function continueFunction;
  DatabaseService databaseService;

  AddTypeAndCode({this.model,this.continueFunction,this.databaseService});
  @override
  _AddTypeAndCodeState createState() => _AddTypeAndCodeState();
}

class _AddTypeAndCodeState extends State<AddTypeAndCode> {
  final _key = GlobalKey<FormState>();
  String productCode;
  bool isLoading = false;
  String productType;
  String sellingType;
  bool isCategorySelected = false;

  List<Widget> productCategoryList = [];
  List<DropdownMenuItem<String>> packedType = [
    DropdownMenuItem<String>(child: Text(lWeight),value:lWeight ,),
     DropdownMenuItem<String>(child: Text(lPack),value: lPack,),
     DropdownMenuItem<String>(child: Text(lPiece),value:lPiece ,),
  ];

  @override
  void initState() {
    super.initState();
    LoadInitial();
  }
  Future<void> LoadInitial() async {
    setState(() {
      isLoading = true;
    });
    List<String> list = await widget.databaseService.getProductTypes();
    productCategoryList = list.map((e) => DropdownMenuItem<String>(
      value: e,
      child: Text(e),
    )).toList();
    isLoading = false;
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final databseService = Provider.of<DatabaseService>(context,listen: false);
    if(isLoading){
      return LoadingVidget();
    }
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Image.asset("asset/listing.png",height: 300,),
                SizedBox(height: height * 0.01,),
                TextFormField(
                  decoration: inputforAppform.copyWith(labelText: 'Enter New Product Code'),
                  onChanged: (val)=> productCode = val,
                  validator: (val)=>val.isEmpty?'Enter Code':null,
                ),
                SizedBox(height: height * 0.01,),
                // TextFormField(
                //   decoration: inputforAppform.copyWith(labelText: 'Enter New Product Code'),
                //
                //
                // ),
                DropdownButtonFormField(
                  hint: Text("Category"),
                  decoration: inputforAppform,
                  validator: (val) => val == null ? "Select Category" : null,

                  onChanged: (val){
                    productType = val;
                    setState(() {
                      isCategorySelected = true;
                    });
                  },
                  items: productCategoryList,
                ),
                if(isCategorySelected)  Padding(
                  padding:  EdgeInsets.only(top: height * 0.01),
                  child: DropdownButtonFormField(
                    hint: Text("Selling type"),
                    decoration: inputforAppform,
                    validator: (val) => val == null ? "Select Selling Type" : null,

                    onChanged: (val){
                      sellingType = val;
                    },
                    items: packedType,
                  ),
                ),
                Center(
                  child: RaisedButton(
                    shape: StadiumBorder(),
                    color: CommonAssets.shoppytitilecolor,
                    onPressed: ()async {
                     if(_key.currentState.validate()){
                       productCode.toUpperCase();
                       bool res = await databseService.isCodeAlredyUsed(productCode.trim());
                       if(res){
                         SnackBar s = SnackBar(content: Text("Code already used with other product"));
                         Scaffold.of(context).showSnackBar(s);
                         return;
                       }
                       widget.model.productCode = productCode.toUpperCase();
                       widget.model.productType = productType;
                       widget.model.sellingType = sellingType;
                       widget.continueFunction();

                     }
                    },

                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: CommonAssets.buttontextcolor,
                          fontSize: height *0.025,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddImage extends StatefulWidget {
  Function function;
  ItemModel model;
  AddImage({@required this.function,@required this.model});
  @override
  _AddImageState createState() => _AddImageState(model: model);
}

class _AddImageState extends State<AddImage> {
  File _image;
  List<File> _imagefilelist = List();
  int showimageindex = -1;
  _AddImageState({ItemModel model}){
    if(model.imagesToUpload != null){
      _imagefilelist = model.imagesToUpload;
      showimageindex = 0;
    }
  }
  getimage(ImageSource source) async {
    PickedFile pickfile = await ImagePicker().getImage(source: source);
    setState(() {
      showimageindex = -1;
      _image = File(pickfile.path);
      _imagefilelist.add(_image);
    });
  }
  deleteCurentIage(){
    return showDialog(context: context,
    child: AlertDialog(
      content: Text("Do you want to delete?"),
      actions: [
        GestureDetector(child: Text("yes",style: TextStyle(color: CommonAssets.shoppyErrorColor),),
        onTap: (){
          _imagefilelist.removeAt(showimageindex);
          _image = null;
          showimageindex = -1;
          setState(() {

          });
          Navigator.pop(context);
        },),
        GestureDetector(child: Text("No"),onTap: (){

        },),
      ],
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [

            Text("Upload images of the product",
            style: CommonAssets.Title1,
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20,),
              child: Container(
                height: size.height * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.7,
                          height: size.height * 0.32,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: CommonAssets.shoppytitilecolor2,
                                width: 0.5,
                              ),
                            ),
                            child: showimageindex == -1
                                ? _image == null
                                ? Center(
                              child: Text('Select Image'),
                            )
                                : Image.file(_image)
                                : Image.file(_imagefilelist[showimageindex]),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              shape: StadiumBorder(),
                              color: CommonAssets.shoppytitilecolor,
                              onPressed: () {
                                getimage(ImageSource.camera);
                              },
                              child: Icon(
                                Icons.camera,
                                color: CommonAssets.buttoncolor,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            RaisedButton(
                              shape: StadiumBorder(),
                              color: CommonAssets.shoppytitilecolor,
                              onPressed: () {
                                getimage(ImageSource.gallery);
                              },
                              child: Icon(
                                Icons.folder,
                                color: CommonAssets.buttoncolor,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            if (showimageindex != -1 )RaisedButton(
                              shape: StadiumBorder(),
                              color: CommonAssets.shoppyErrorColor,
                              onPressed: () {
                                deleteCurentIage();
                              },
                              child: Icon(
                                Icons.delete,
                                color: CommonAssets.buttoncolor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CommonAssets.shoppytitilecolor2,
                              width: 0.5)),
                      width: size.width * 0.2,
                      child: ListView.builder(
                          itemCount: _imagefilelist.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  showimageindex = index;
                                });
                              },
                              // onLongPress: () {
                              //   setState(() {
                              //     print('ss');
                              //     showimageindex = -1;
                              //     _imagefilelist.removeAt(index);
                              //   });
                              // },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: CommonAssets.shoppytitilecolor,
                                        width: 0.5)),
                                child: Image.file(
                                  _imagefilelist[index],
                                  height: size.height * 0.1,
                                  width: size.width * 0.18,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50,),
            Center(
                    child: RaisedButton(
                      disabledElevation: 0,
                      elevation: 2,
                      shape: StadiumBorder(),
                      color: CommonAssets.shoppytitilecolor,
                      onPressed: _imagefilelist.length == 0 ? null : (){
                        // DatabaseService().uploadItem(_imagefilelist);
                        // if(_formkey.currentState.validate()){
                        //
                        // }
                        widget.model.imagesToUpload = _imagefilelist;
                        widget.function();
                        // DatabaseService().SaveNewItem(widget.model);
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: CommonAssets.buttontextcolor,
                            fontSize: size.height *0.025
                        ),
                      ),
                    ),
                  )

          ],
        ),
      ),
    );
  }
}

class AddDetail extends StatefulWidget {
  Function backFunction;
  Function savFunction;
  ItemModel model;
  AddDetail({@required this.backFunction,@required this.savFunction,@required this.model});
  @override
  _AddDetailState createState() => _AddDetailState();
}

class _AddDetailState extends State<AddDetail> {
  String producName;
  String unit;
  int sellprice;
  int MRP;
  int available;
  List<String> keywordlist =  List();
  String productDes;
  String keyword;
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  int quantity = 0;
  List<DropdownMenuItem<String>> unitlist = [];
  @override
  void initState() {
    print( "${LocalData.unitType[widget.model.sellingType]}seeelingType");

    unitlist = LocalData.unitType[widget.model.sellingType].map((e) => DropdownMenuItem<String>(child: Text(e),value: e,)).toList();
    print(unitlist);
    super.initState();
    sellprice = 0;
    MRP =0;
    available = 0;

  }


  @override
  Widget build(BuildContext context) {
    print(widget.model.imagesToUpload.length);
    final size = MediaQuery.of(context).size;
    return  isLoading ? LoadingVidget() : Padding(
      padding: const EdgeInsets.only(top:16.0,left: 8.0,right: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Details',
                  style: TextStyle(
                      color: Colors.black45,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                SizedBox(width: 5,),
                Text(
                  ':',
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: inputforAppform.copyWith(labelText: 'Product Name'),
                    initialValue: producName,
                    onChanged: (val)=> producName = val,
                    validator: (val)=>val.isEmpty?'Enter The Product Title':null,
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  TextFormField(
                    decoration: inputforAppform.copyWith(labelText: "Description",counterText: ""),
                    validator: (val)=>val.isEmpty?'Enter The Description ':null,
                    initialValue: productDes,
                    onChanged: (val) => productDes = val,
                    maxLength: 150,
                    maxLines: 4,
                    minLines: 4,
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: available.toString(),
                          keyboardType: TextInputType.phone,
                          decoration: inputforAppform.copyWith(labelText: 'Available Quantity'),
                          onChanged: (val)=> available =int.parse(val),
                          validator: numbervalidtion,

                        ),

                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text("Set Selling price and MRP of Item accordingly",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w400,fontSize: 14),),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: MRP.toString(),
                          keyboardType: TextInputType.phone,
                          decoration: inputforAppform.copyWith(labelText: 'MRP'),
                          onChanged: (val)=> MRP =int.parse(val),
                          validator: numbervalidtion,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: sellprice.toString(),
                          keyboardType: TextInputType.phone,
                          decoration: inputforAppform.copyWith(labelText: 'Selling Price'),
                          onChanged: (val)=> sellprice =int.parse(val),
                          validator: numbervalidtion,
                        ),

                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      // Expanded(
                      //   child: DropdownButtonFormField(
                      //     decoration: inputforAppform,
                      //     value: unitlist[0].value, //// TODO : SELECT VALUE
                      //     onChanged: (val){
                      //       setState(() {
                      //         unit = val;
                      //       });
                      //     },
                      //     items: unitlist,
                      //   ),
                      // ),


                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text("unit"),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: quantity.toString(),
                          keyboardType: TextInputType.phone,
                          decoration: inputforAppform.copyWith(labelText: 'Quantity'),
                          onChanged: (val)=> quantity =int.parse(val),
                          validator: numbervalidtion,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),

                      Expanded(
                        child: DropdownButtonFormField(
                          decoration: inputforAppform,
                          value: unitlist[0].value, //// TODO : SELECT VALUE
                          onChanged: (val){
                            setState(() {
                              unit = val;
                            });
                          },
                          items: unitlist,
                        ),
                      ),


                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text("set keywords for better searching",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w400,fontSize: 14),),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  Row(

                    children: [

                      Expanded(
                        child: Container(
                            padding: EdgeInsets.all(5),
                            height: size.height *0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: CommonAssets.shoppytitilecolor,

                              ),

                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 4,),
                                Row(
                                  children: [

                                    Expanded(
                                      child: TextFormField(
                                        decoration: inputforAppform.copyWith(labelText: 'Key Word'),
                                        onChanged: (val)=>keyword = val,
                                        //validator: numbervalidtion,
                                      ),
                                    ),
                                    IconButton(
                                      icon:Icon(Icons.add),
                                      onPressed: (){
                                        keywordlist.add(keyword);
                                        print(keyword);
                                        setState(() {
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: keywordlist.length,
                                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    //
                                    //   crossAxisCount: 2
                                    // ),

                                      itemBuilder: (context,indexkeyword){
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(keywordlist[indexkeyword]),
                                            IconButton(
                                              onPressed: (){
                                                setState(() {
                                                  keywordlist.removeAt(indexkeyword);
                                                });
                                              },
                                              icon: Icon(Icons.cancel,color: Colors.red[200],),
                                            )
                                          ],
                                        );
                                      }),
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
            SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        color: CommonAssets.shoppytitilecolor,
                        onPressed: (){
                          // DatabaseService().uploadItem(_imagefilelist);
                          // if(_formkey.currentState.validate()){
                          //
                          // }
                          widget.backFunction();
                        },

                        child: Text(
                          'Back',
                          style: TextStyle(
                              color: CommonAssets.buttontextcolor,
                              fontSize: size.height *0.025
                          ),
                        ),
                      ),
                    ),
                  Center(
                    child: RaisedButton(

                      shape: StadiumBorder(),
                      color: CommonAssets.shoppytitilecolor,
                      onPressed:  () async {
                        setState(() {
                          isLoading = true;
                        });
                        // DatabaseService().uploadItem(_imagefilelist);
                        if(_formkey.currentState.validate()){
                          widget.model.productName = producName;
                          widget.model.description = productDes;
                          widget.model.availableQuantity = available;
                          widget.model.mrp = MRP;
                          widget.model.sellingPrice = sellprice;
                          widget.model.unit = unit;
                          widget.model.quantityAsPrice = quantity;
                          widget.model.keyWords = keywordlist;
                          final databaseService = Provider.of<DatabaseService>(context,listen: false);
                         await databaseService.SaveNewItem(widget.model);
                         SnackBar s = SnackBar(content: Text("done"),duration: Duration(seconds: 1),);
                         Scaffold.of(context).showSnackBar(s);
                         Navigator.pop(context);
                        }
                        setState(() {
                          isLoading = false;
                        });

                      },
                      child: Text(
                        'Save Item',
                        style: TextStyle(
                            color: CommonAssets.buttontextcolor,
                            fontSize: size.height *0.025
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 10,),


          ],
        ),
      ),
    );
  }
  String numbervalidtion(String value){
    Pattern pattern = '^[0-9]+';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter The Number Only';
    } else {
      return null;
    }
  }
}


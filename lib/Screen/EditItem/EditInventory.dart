import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppy_seller/Common/Appbar/CommonAppbar.dart';
import 'package:shoppy_seller/Common/CommomAssets.dart';
import 'package:shoppy_seller/Common/CommonWidget.dart';
import 'package:shoppy_seller/CommonAssets/inputForm.dart';
import 'package:shoppy_seller/Model/ItemModel.dart';
import 'package:shoppy_seller/Services/DatabaseService.dart';
import 'package:shoppy_seller/Services/LocalData.dart';
import 'package:shoppy_seller/validator.dart';
class EditInventory extends StatefulWidget {
  ItemModel model;
  EditInventory({@required this.model});
  @override
  _EditInventoryState createState() => _EditInventoryState();
}

class _EditInventoryState extends State<EditInventory> {
  String unit;
  String productType;
  int sellprice;
  int MRP;
  int available;
  List<String> keywordlist =  List();
  String productDes;
  String keyword;
  File _image;
  List<String> _imagefilelist = List();
  int showimageindex = -1;
  @override
  void initState() {

    unit = widget.model.unit;
    MRP = widget.model.mrp;
    sellprice = widget.model.sellingPrice;
    available  = widget.model.availableQuantity;
    productDes  = widget.model.description;
    _imagefilelist = widget.model.urls;
    print("${widget.model.sellingType} selling type");
    super.initState();
  }
  getimage(ImageSource source) async {
    PickedFile pickfile = await ImagePicker().getImage(source: source);
    setState(() {
      showimageindex = -1;
      _image = File(pickfile.path);
      // _imagefilelist.add(_image);
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
    final height =  MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CommonAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.model.productCode,
                decoration: inputforAppform.copyWith(labelText: 'Product Code'),
                enabled: false,
                validator: (val)=>val.isEmpty?'Enter Code':null,
              ),
              SizedBox(height: height * 0.01,),
              TextFormField(
                initialValue: widget.model.productName,
                decoration: inputforAppform.copyWith(labelText: 'Product Name'),
                enabled: false,
                validator: (val)=>val.isEmpty?'Enter Code':null,
              ),
              SizedBox(height: height * 0.01,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 20,),
                child: Container(
                  height: height * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.7,
                            height: height * 0.32,
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
                                  : Image.network(_imagefilelist[showimageindex]),
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
                                width: width * 0.05,
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
                                width: width * 0.05,
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
                        width: width * 0.2,
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
                                  child: Image.network(
                                    _imagefilelist[index],
                                    height: height * 0.1,
                                    width: width * 0.18,
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

              TextFormField(
                initialValue: productDes,
                decoration: inputforAppform.copyWith(labelText: "Description",counterText: ""),
                validator: (val)=>val.isEmpty?'Enter The Description ':null,
                onChanged: (val) => productDes = val,
                maxLength: 150,
                maxLines: 4,
                minLines: 4,
              ),
              SizedBox(
                height: height * 0.015,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expanded(
                  //   child: DropdownButtonFormField(
                  //     hint: Text("Category"),
                  //     decoration: inputforAppform,
                  //     validator: (val) => val == null ? "Select Category" : null,
                  //
                  //     onChanged: (val){
                  //       productType = val;
                  //     },
                  //     /////TODO : attach category
                  //     items: <String>['KG','Piece']
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  // SizedBox(width: 10,),
                  Expanded(
                    child: TextFormField(
                      initialValue: available.toString(),
                      keyboardType: TextInputType.phone,
                      decoration: inputforAppform.copyWith(labelText: 'Available Quantity'),
                      onChanged: (val)=> available =int.parse(val),
                      validator: validator.numbervalidtion,

                    ),

                  ),
                ],
              ),
              SizedBox(
                height: height * 0.015,
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
                      validator: validator.numbervalidtion,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: sellprice.toString(),
                      keyboardType: TextInputType.phone,
                      decoration: inputforAppform.copyWith(labelText: 'Selling Price'),
                      onChanged: (val)=> sellprice =int.parse(val),
                      validator: validator.numbervalidtion,
                    ),

                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          " / ",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: height * 0.015,
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                            decoration: inputforAppform,
                            value: unit,
                            onChanged: (val){
                              setState(() {
                                unit = val;
                              });
                            },
                            items: LocalData.unitType[widget.model.sellingType]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
              CommonWidget.getRaisedButton(text: "Save",
              function: (){

              },
              context: context)
            ],
          ),
        ),
      ),
    );
  }
}

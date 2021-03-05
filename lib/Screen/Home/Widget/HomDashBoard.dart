import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shoppy_seller/Common/Appbar/CommonAppbar.dart';
import 'package:shoppy_seller/Common/CommonWidget.dart';
import 'package:shoppy_seller/Screen/Home/Drawer.dart';

class HomeDashBord extends StatefulWidget {
  @override
  _HomeDashBordState createState() => _HomeDashBordState();
}

class _HomeDashBordState extends State<HomeDashBord> {
  List<charts.Series<Pollution, String>> _seriesData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<Pollution, String>>();
    _generateData();

  }
  _generateData() {
    var data1 = [
      new Pollution(1980, 'USA', 30,Colors.green),
      new Pollution(1980, 'B', 40,Colors.grey),
      new Pollution(1980, 'Europe', 10,Colors.red),
      new Pollution(1980, 'D', 50,Colors.tealAccent),
      new Pollution(1980, 'Japan', 60,Colors.blue),
      new Pollution(1980, 'S', 15,Colors.yellow),
      new Pollution(1980, 'Canada', 15,Colors.purple),
      new Pollution(1980, 'K', 15,Colors.deepOrangeAccent),
    ];




    _seriesData.add(
      charts.Series(
        labelAccessorFn: (Pollution title, _) => "${title.place}",
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(pollution.color),
        colorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(pollution.color),

      ),


    );


  }
  @override


  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical:  size.height *0.01),
          //   child: Container(
          //     height: size.height *0.1,
          //     child: Card(
          //       shape: RoundedRectangleBorder(
          //           side: BorderSide(
          //               color: Colors.black.withOpacity(0.2)
          //           )
          //       ),
          //       child: Padding(
          //         padding:  EdgeInsets.all(8.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //
          //
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceAround,
          //               children: [
          //                 Text(
          //                   'PageView',
          //                   style: TextStyle(
          //                       fontSize: size.height * 0.025,
          //                       fontWeight: FontWeight.bold
          //                   ),
          //                 ),
          //
          //                 Text(
          //                   NumberFormat.compact().format(20000000000),
          //                   style: TextStyle(
          //                     fontSize: size.height * 0.020,
          //                   ),),
          //
          //               ],
          //             ),
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceAround,
          //               children: [
          //                 Text(
          //                   'Order',
          //                   style: TextStyle(
          //                       fontSize: size.height * 0.025,
          //                       fontWeight: FontWeight.bold
          //                   ),
          //                 ),
          //
          //                 Text(
          //                   NumberFormat.compact().format(1000),
          //                   style: TextStyle(
          //                     fontSize: size.height * 0.020,
          //                   ),),
          //
          //               ],
          //             ),
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceAround,
          //               children: [
          //                 Text(
          //                   'Sales',
          //                   style: TextStyle(
          //                       fontSize: size.height * 0.025,
          //                       fontWeight: FontWeight.bold
          //                   ),
          //                 ),
          //
          //                 Text(
          //                   NumberFormat.compact().format(100),
          //                   style: TextStyle(
          //                     fontSize: size.height * 0.020,
          //                   ),),
          //
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height:size.height *0.4,
            child:Card(

              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black.withOpacity(0.5),
                  )
              ),
              elevation: 10.0,
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: size.height *0.01,horizontal: size.width *0.01),
                child: charts.BarChart(
                  _seriesData,
                  // animate: true,
                  // animationDuration: Duration(seconds: 2),
                  behaviors: [
                    new charts.DatumLegend(
                      outsideJustification: charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 2,
                      cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.black,
                          fontFamily: 'Georgia',
                          fontSize: 15),
                    )
                  ],
                  // defaultRenderer: new charts.ArcRendererConfig(
                  //     arcWidth: 100,
                  //     arcRendererDecorators: [
                  //       new charts.ArcLabelDecorator(
                  //           labelPosition: charts.ArcLabelPosition.inside)
                  //     ])
                ),
              ),
            )
            , ),
          SizedBox(height:  size.height*0.05,),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: size.height *0.01,horizontal: size.width *0.01),
            child: Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                  )
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: size.height *0.01,horizontal: size.width *0.02),
                child: Column(

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              fontSize: size.height* 0.02,
                              color: Colors.red
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                              fontSize: size.height* 0.02,
                              color: Colors.red
                          ),)
                      ],
                    ),
                    SizedBox(height: size.height *0.01,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Complete',
                          style: TextStyle(
                            fontSize: size.height* 0.02,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: size.height* 0.02
                          ),)
                      ],
                    ),
                    SizedBox(height: size.height *0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pending',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: size.height* 0.02
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: size.height* 0.02
                          ),)
                      ],
                    ),
                    SizedBox(height: size.height *0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Processing',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: size.height* 0.02
                          ),
                        ),
                        Text(
                          '0',

                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: size.height* 0.02
                          ),)
                      ],
                    ),

                    SizedBox(height: size.height *0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cancelled',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: size.height* 0.02
                          ),
                        ),
                        Text(
                          '0',

                          style: TextStyle(
                              color: Colors.red,
                              fontSize: size.height* 0.02
                          ),)
                      ],
                    ),
                    SizedBox(height: size.height *0.01,),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
class Pollution {
  String place;
  int year;
  int quantity;
  Color color;

  Pollution(this.year, this.place, this.quantity,this.color);
}
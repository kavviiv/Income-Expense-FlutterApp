import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:inandex/Page/ExChart.dart';
import 'package:inandex/Page/InChart.dart';
import 'package:pie_chart/pie_chart.dart';


enum LegendShape { Circle, Rectangle }
class AllChart extends StatefulWidget {
  @override

  _AllChartState createState() => _AllChartState();
}

class _AllChartState extends State<AllChart>  {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  

 void initState() {
    super.initState();
    print(aa);
  }
    

  
  Map<String, double> dataMap = {
    "รายรับ": aa,
    "รายจ่าย": bb,
 
  };
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  ChartType _chartType = ChartType.ring;
  bool _showCenterText = true;
  double _ringStrokeWidth = 32;
  double _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  LegendShape _legendShape = LegendShape.Circle;
  LegendPosition _legendPosition = LegendPosition.right;

  int key = 0;

  @override
  Widget build(BuildContext context) {    
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing,
      chartRadius: MediaQuery.of(context).size.width / 5.0 > 500
          ? 300
          : MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType,
      centerText: _showCenterText ? "" : null,
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.Circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth,
    );
    // final settings = SingleChildScrollView(
    //   child: Card(
    //     margin: EdgeInsets.all(12),
    //     child: Column(
    //       children: [
    //         ListTile(
    //           title: Text(
    //             'Pie Chart Options'.toUpperCase(),
    //             style: Theme.of(context).textTheme.overline.copyWith(
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text("chartType"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<ChartType>(
    //               value: _chartType,
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("disc"),
    //                   value: ChartType.disc,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("ring"),
    //                   value: ChartType.ring,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _chartType = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text("ringStrokeWidth"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<double>(
    //               value: _ringStrokeWidth,
    //               disabledHint: Text("select chartType.ring"),
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("16"),
    //                   value: 16,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("32"),
    //                   value: 32,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("48"),
    //                   value: 48,
    //                 ),
    //               ],
    //               onChanged: (_chartType == ChartType.ring)
    //                   ? (val) {
    //                       setState(() {
    //                         _ringStrokeWidth = val;
    //                       });
    //                     }
    //                   : null,
    //             ),
    //           ),
    //         ),
    //         SwitchListTile(
    //           value: _showCenterText,
    //           title: Text("showCenterText"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showCenterText = val;
    //             });
    //           },
    //         ),
    //         ListTile(
    //           title: Text("chartLegendSpacing"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<double>(
    //               value: _chartLegendSpacing,
    //               disabledHint: Text("select chartType.ring"),
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("16"),
    //                   value: 16,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("32"),
    //                   value: 32,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("48"),
    //                   value: 48,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("64"),
    //                   value: 64,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _chartLegendSpacing = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text(
    //             'Legend Options'.toUpperCase(),
    //             style: Theme.of(context).textTheme.overline.copyWith(
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //           ),
    //         ),
    //         SwitchListTile(
    //           value: _showLegendsInRow,
    //           title: Text("showLegendsInRow"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showLegendsInRow = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showLegends,
    //           title: Text("showLegends"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showLegends = val;
    //             });
    //           },
    //         ),
    //         ListTile(
    //           title: Text("legendShape"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<LegendShape>(
    //               value: _legendShape,
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("BoxShape.circle"),
    //                   value: LegendShape.Circle,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("BoxShape.rectangle"),
    //                   value: LegendShape.Rectangle,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _legendShape = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text("legendPosition"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<LegendPosition>(
    //               value: _legendPosition,
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("left"),
    //                   value: LegendPosition.left,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("right"),
    //                   value: LegendPosition.right,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("top"),
    //                   value: LegendPosition.top,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("bottom"),
    //                   value: LegendPosition.bottom,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _legendPosition = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text(
    //             'Chart values Options'.toUpperCase(),
    //             style: Theme.of(context).textTheme.overline.copyWith(
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //           ),
    //         ),
    //         SwitchListTile(
    //           value: _showChartValueBackground,
    //           title: Text("showChartValueBackground"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValueBackground = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showChartValues,
    //           title: Text("showChartValues"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValues = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showChartValuesInPercentage,
    //           title: Text("showChartValuesInPercentage"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValuesInPercentage = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showChartValuesOutside,
    //           title: Text("showChartValuesOutside"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValuesOutside = val;
    //             });
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text("กราฟสรุปรายรับรายจ่าย"),
        // actions: [
        //   RaisedButton(
        //     onPressed: () {
        //       setState(() {
        //         key = key + 1;
        //       });
        //     },
        //     child: Text("Reload".toUpperCase()),
        //   ),
        // ],
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth >= 500) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: chart,
                ),
                // Flexible(
                //   flex: 1,
                //  // child: settings,
                // )
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: chart,
                    margin: EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                  ),
                  //settings,
                ],
              ),
            );
          }
        },
      ),
    );
    
    }
}
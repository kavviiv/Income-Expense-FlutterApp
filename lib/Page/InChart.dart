import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'dart:math';

var aa;
var salary;
var special;
var sell;
var inother;

class IncomeChart extends StatefulWidget {
  @override
  _IncomeChartState createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  getSalary() async {
    QuerySnapshot snapshot = await firestoreInstance
        .collection(firebaseUser.uid)
        .doc("รายรับ")
        .collection('รายรับ')
        .where("ประเภท", isEqualTo: "เงินเดือน")
        .get();

    if (snapshot == null) {
      return;
    }
    snapshot.docs.forEach((doc) {
      var ds = snapshot.docs;
      double sum = 0.00;
      for (int i = 0; i < ds.length; i++) sum += int.parse(ds[i]['จำนวนเงิน']);
      double total = sum;
      salary = total;
    });
    print("specail: $salary");
  }

  getSpecial() async {
    QuerySnapshot snapshot = await firestoreInstance
        .collection(firebaseUser.uid)
        .doc("รายรับ")
        .collection('รายรับ')
        .where("ประเภท", isEqualTo: "งานพิเศษ")
        .get();

    if (snapshot == null) {
      return;
    }
    snapshot.docs.forEach((doc) {
      var ds = snapshot.docs;
      double sum = 0.00;
      for (int i = 0; i < ds.length; i++) sum += int.parse(ds[i]['จำนวนเงิน']);
      double total = sum;
      special = total;
    });
    print("salary: $special");
  }

  getSell() async {
    QuerySnapshot snapshot = await firestoreInstance
        .collection(firebaseUser.uid)
        .doc("รายรับ")
        .collection('รายรับ')
        .where("ประเภท", isEqualTo: "ขายของ")
        .get();

    if (snapshot == null) {
      return;
    }
    snapshot.docs.forEach((doc) {
      var ds = snapshot.docs;
      double sum = 0.00;
      for (int i = 0; i < ds.length; i++) sum += int.parse(ds[i]['จำนวนเงิน']);
      double total = sum;
      sell = total;
    });
    print("sell: $sell");
  }

  getInOther() async {
    QuerySnapshot snapshot = await firestoreInstance
        .collection(firebaseUser.uid)
        .doc("รายรับ")
        .collection('รายรับ')
        .where("ประเภท", isEqualTo: "อื่นๆ")
        .get();

    if (snapshot == null) {
      return;
    }
    snapshot.docs.forEach((doc) {
      var ds = snapshot.docs;
      double sum = 0.00;
      for (int i = 0; i < ds.length; i++) sum += int.parse(ds[i]['จำนวนเงิน']);
      double total = sum;
      inother = total;
    });
    print("other: $inother");
  }

  List<AppDownloads> data;

  void initState() {
    super.initState();
    getSalary();
    getSpecial();
    getSell();
    getInOther();
    getDt();

    data = [
      AppDownloads(
        type: 'เงินเดือน',
        count: salary,
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      AppDownloads(
        type: 'งานพิเศษ',
        count: special,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      AppDownloads(
        type: 'ขายของ',
        count: sell,
        barColor: charts.ColorUtil.fromDartColor(Colors.yellowAccent),
      ),
      AppDownloads(
        type: 'อื่นๆ',
        count: inother,
        barColor: charts.ColorUtil.fromDartColor(Colors.greenAccent),
      ),
    ];
  }

  void getDt() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    // String datte = formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('กราฟสรุปรายรับ'),
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Container(
            child: Container(
              alignment: Alignment.center,
              margin: new EdgeInsets.symmetric(horizontal: 40.0),
              padding: EdgeInsets.only(top: 30, left: 70),
              height: 170,
              width: 350,
              color: Colors.white,
              child: Container(
                child: StreamBuilder(
                    stream: firestoreInstance
                        .collection(firebaseUser.uid)
                        .doc("รายรับ")
                        .collection("รายรับ")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      var ds = snapshot.data.documents;
                      double sum = 0.00;
                      for (int i = 0; i < ds.length; i++)
                        sum += int.parse(ds[i]['จำนวนเงิน']);
                      double total = sum;
                      aa = total;

                      final DateTime now = DateTime.now();
                      final DateFormat formatter = DateFormat('dd-MM-yyyy');
                      final String formatted = formatter.format(now);
                      String datte = formatted;

                      return Row(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "ยอดรวมรายรับทั้งหมด : $sum" +
                                    "\n ข้อมูล ณ วันที่: " +
                                    "$datte",
                                style: TextStyle(fontSize: 20),
                              ),
                            ))
                      ]);
                    }),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Card(
                  child: MyBarChart(data),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'กราฟสรุปรายรับ',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}

class AppDownloads {
  final String type;
  final double count;
  final charts.Color barColor;

  AppDownloads({
    @required this.type,
    @required this.count,
    @required this.barColor,
  });
}

class MyBarChart extends StatelessWidget {
  final List<AppDownloads> data;

  MyBarChart(this.data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<AppDownloads, String>> series = [
      charts.Series(
          id: 'AppDownloads',
          data: data,
          domainFn: (AppDownloads downloads, _) => downloads.type,
          measureFn: (AppDownloads downloads, _) => downloads.count,
          colorFn: (AppDownloads downloads, _) => downloads.barColor)
    ];

    return charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.groupedStacked,
    );
  }
}

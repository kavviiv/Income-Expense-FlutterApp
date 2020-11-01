import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class IncomeChart extends StatefulWidget {
  @override
  _IncomeChartState createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;


  getCartTotal(String userId) async {

    var cartTotal = 0;

    QuerySnapshot snapshot = await firestoreInstance
        .collection(firebaseUser.uid)
        .doc("รายรับ")
        .collection('รายรับ')
        .get();

    if (snapshot == null) {
      return;
    }

    snapshot.docs.forEach((doc) {
      cartTotal = cartTotal + doc.data()["จำนวนเงิน"];
    });
    print(cartTotal);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
           ));
  }
}

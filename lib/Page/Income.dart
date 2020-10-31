import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inandex/Page/AddIncome.dart';
import 'package:inandex/Page/ExChart.dart';
import 'package:inandex/Page/MainPage.dart';

class IncomePage extends StatefulWidget {
  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //backgroundColor: Colors.red,

        //backgroundColor: Colors.red,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddInPage();
            }));
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: true,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MainPage();
                      }));
                    }),
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(
                    'รายรับ',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                
                ),
              )
            ];
          },
          
        body: StreamBuilder(
          stream: firestoreInstance.collection(firebaseUser.uid).snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot income = snapshot.data.documents[index];
                  return ListTile(
                    title: Text(
                      "จำนวนเงิน: " + " " + income['จำนวนเงิน'],
                      style: TextStyle(fontSize: 25),
                    ),
                    subtitle:
                        Text(income['ประเภท'], style: TextStyle(fontSize: 18)),
                    leading: Icon(Icons.note_add),
                    enabled: true,
                    dense: false,
                    isThreeLine: true,
                  );
                });
          },
        )));
  }
}

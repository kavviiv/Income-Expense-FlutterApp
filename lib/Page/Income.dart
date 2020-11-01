import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inandex/Page/AddIncome.dart';
import 'package:inandex/Page/ExChart.dart';
import 'package:inandex/Page/MainPage.dart';
import 'package:intl/intl.dart';


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
                      icon: Icon(
                        Icons.arrow_back,
                        size: 20,
                      ),
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
                      style: TextStyle(color: Colors.white, fontSize: 24.0),
                    ),
                  ),
                )
              ];
            },
            body: StreamBuilder(
              stream:
                  firestoreInstance.collection(firebaseUser.uid).doc("รายรับ").collection("รายรับ").snapshots(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot income = snapshot.data.documents[index];
                      //DateTime dateCreated = snapshot.data["when"]?.toDate();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 270,
                          height: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5.0,
                                offset: const Offset(0.0, 5.0),
                              ),
                            ],
                          ),
                          
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 10, top: 5),
                            title: Text(
                              "จำนวนเงิน: " +
                                  " " +
                                  income['จำนวนเงิน'] +
                                  " " +
                                  "บาท",
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                                "ประเภท" + " " + income['ประเภท'] + "\n" + income['when'],
                                style: TextStyle(fontSize: 18)),
                            leading: Icon(Icons.note_add, size: 35),
                            enabled: true,
                            dense: false,
                            isThreeLine: true,
                            onLongPress: (){
                              

                            },
                          ),
                        ),
                      );
                    });
              },
            )));
  }
}


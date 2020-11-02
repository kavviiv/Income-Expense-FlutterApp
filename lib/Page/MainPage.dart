import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inandex/Page/AllChart.dart';
import 'package:inandex/Page/ExChart.dart';
import 'package:inandex/Page/Expense.dart';
import 'package:inandex/Page/Income.dart';
import 'package:inandex/Page/SignIn.dart';
import 'package:inandex/Page/InChart.dart';
import 'package:inandex/widget/menu_card.dart';
import 'package:inandex/constants.dart';

class MainPage extends StatefulWidget {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  MainPage({this.firebaseUser, Key key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

var firebaseUser = FirebaseAuth.instance.currentUser.uid;

final databaseReference = FirebaseDatabase.instance
    .reference()
    .child("user")
    .child(firebaseUser)
    .child("User");

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  String amm = "";
  //final databaseReference = FirebaseDatabase.instance.reference().child("user").reference().child("User");
  @override
  initState() {
    super.initState();
    readData();
  }

  void readData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      String tempTotal = snapshot.value["Name"];
      setState(() {
        String total = tempTotal;
        debugPrint(total.toString());
      });
      print('Data : ${snapshot.value["Name"]}');
      String amm = snapshot.value["Name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.yellowAccent,
          shape: const CircularNotchedRectangle(),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: Text('Welcome $amm',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            height: 60.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            logout(context);
          },
          child: Icon(Icons.people),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        backgroundColor: Colors.grey[250],
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: .85,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              children: <Widget>[
                            MenuCard(
                              title: "รายรับ",
                              svgSrc: "assets/icons/income.svg",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return IncomePage();
                                  }),
                                );
                              },
                            ),
                            MenuCard(
                              title: "รายจ่าย",
                              svgSrc: "assets/icons/expense.svg",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ExpensePage();
                                  }),
                                );
                              },
                            ),
                            MenuCard(
                              title: "กราฟสรุป \n รายรับ",
                              svgSrc: "assets/icons/increase.svg",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return IncomeChart();
                                  }),
                                );
                              },
                            ),
                            MenuCard(
                              title: "กราฟสรุป \n รายจ่าย",
                              svgSrc: "assets/icons/chart.svg",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ExCahart();
                                  }),
                                );
                              },
                            ),
                          ])),
                      Container(
                        height: 295,
                        child: Center(
                          
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Stack(children: <Widget>[
                              GestureDetector(
                              onTap: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return AllChart();
                                  }),
                                );

           

           
                              },
                            ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 45),
                                    width: 490,
                                    height: 190,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(13),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 11.0,
                                          offset: const Offset(0.0, 0.0),
                                        ),
                                      ],
                                    ),
                                    child: Image(
                                      image: AssetImage('assets/images/pie.png'),
                                      width: 5,
                                      height: 5,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 200,
                                  child: Container(
                                padding: EdgeInsets.only(top: 15),
                                child: Text('กราฟสรุปรายรับ - รายจ่าย',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold)),
                                alignment: Alignment.bottomCenter,
                              )),
                            ]),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ));
  }

  void logout(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        ModalRoute.withName('/'));
  }
}

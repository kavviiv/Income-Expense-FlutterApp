import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inandex/Page/Income.dart';
import 'package:inandex/Page/SignIn.dart';
import 'package:inandex/widget/menu_card.dart';
import 'package:inandex/constants.dart';

class MainPage extends StatefulWidget {
  final FirebaseUser user;
  

  MainPage({ this.user,Key key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  



  

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.yellowAccent,
          shape: const CircularNotchedRectangle(),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10),
              child: Text("Welcome, " ,
                  style: TextStyle(
                    fontSize: 25,
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
          child: Icon(Icons.block),
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
                              press: () {},
                            ),
                            MenuCard(
                              title: "กราฟสรุป \n รายรับ",
                              svgSrc: "assets/icons/increase.svg",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return LoginPage();
                                  }),
                                );
                              },
                            ),
                            MenuCard(
                              title: "กราฟสรุป \n รายจ่าย",
                              svgSrc: "assets/icons/chart.svg",
                              press: () {},
                            ),
                          ])),
                      // Container(
                      //     child: Container(
                      //   padding: EdgeInsets.only(top: 2),
                      //   child: Text('กราฟสรุปรายรับ - รายจ่าย',
                      //       style: TextStyle(
                      //           fontSize: 23, fontWeight: FontWeight.bold)),
                      //   alignment: Alignment.bottomCenter,
                      // )),

                      Stack(children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 45),
                          child: Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Image(
                              image: AssetImage('assets/images/pie.png'),
                              width: 5,
                              height: 5,
                            ),
                          ),
                          width: 390,
                          height: 190,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 11.0,
                                offset: const Offset(0.0, 10.0),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            child: Container(
                          padding: EdgeInsets.only(top: 150),
                          child: Text('กราฟสรุปรายรับ - รายจ่าย',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold)),
                          alignment: Alignment.bottomCenter,
                        )),
                      ])
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

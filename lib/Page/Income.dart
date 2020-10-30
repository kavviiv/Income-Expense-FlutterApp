import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:inandex/Page/AddIncome.dart';

class IncomePage extends StatefulWidget {
  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
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
      )
    ]));
  }
}

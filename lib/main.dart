import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inandex/Page/AddIncome.dart';
import 'package:inandex/Page/InChart.dart';

import 'package:inandex/Page/Income.dart';
import 'package:inandex/Page/MainPage.dart';
import 'package:inandex/Page/SignIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inandex/Page/AllChart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IncomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

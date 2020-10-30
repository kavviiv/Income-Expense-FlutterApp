import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inandex/Page/MainPage.dart';
import 'package:inandex/Page/SignUp.dart';
import 'MainPage.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Container(
              height: 175,
              width: 1500,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 50, top: 80),
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: 'TH Kodchasal'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.only(top: 50),
              width: 350.0,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle:
                      // TextStyle(fontSize: 14, color: Colors.grey.shade400),
                      TextStyle(fontSize: 14, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      // color: Colors.grey.shade300,
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.red,
                      )),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 350.0,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle:
                      // TextStyle(fontSize: 14, color: Colors.grey.shade400),
                      TextStyle(fontSize: 14, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      // color: Colors.grey.shade300,
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.red,
                      )),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 20),
                width: 350,
                height: 70,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      side: BorderSide(color: Colors.black)),
                  onPressed: () => {signIn()},
                  color: Colors.black,
                  child: Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 250),
              child: Text(
                'ลืมรหัสผ่าน?',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 150,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "ยังไม่มีบัญชี?",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUpPage();
                      }));
                    },
                    child: Text(
                      "สมัครสมาชิก",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  )
                ],
              ),
            )
          ],
        )));
  }
  signIn() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((user) {
          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
      
      checkAuth(context); // add here
    }).catchError((error) {
      print(error.message);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(error.message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    });
  }

  Future checkAuth(BuildContext context) async {
    final User user = _auth.currentUser;
    if (user != null) {
      print("Already singed-in with");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    }
  }
 }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inandex/Page/MainPage.dart';
import 'package:inandex/Page/SignIn.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseDatabase.instance.reference().child('user');
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
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
                          "SIGN UP",
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
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.only(top: 30),
              width: 350.0,
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "ชื่อผู้ใช้",
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
              //padding: EdgeInsets.only(top: 50),
              width: 350.0,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "E-Mail",
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
            SizedBox(height: 20),
            Container(
              width: 350.0,
              child: TextField(
                controller: confirmController,
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
                  onPressed: () => {signUp()},
                  color: Colors.black,
                  child: Text(
                    'สร้างบัญชีผู้ใช้',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "มีบัญชีอยู่แล้ว",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    child: Text(
                      " เข้าสู่ระบบ",
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

  signUp() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();
    if (password == confirmPassword && password.length >= 6) {
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
       // writeData();
        print("Sign up user successful.");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
            ModalRoute.withName('/'));
            writeData();
      }
      ).catchError((error) {
        print(error.message);
      });
    } else {
      print("Password and Confirm-password is not match.");
    }
  }


final FirebaseAuth auth = FirebaseAuth.instance;

void writeData() {
    String email = emailController.text.trim();
    String userName = usernameController.text.trim();
    final User user = auth.currentUser;
    final uid = user.uid;
     db.child('User').set({
      'Name':userName,
      'Email':email
    });
    // here you write the codes to input the data into firestore
  }

  // void writeData() async{
  //   String email = emailController.text.trim();
  //   String userName = usernameController.text.trim();
  //   final FirebaseUser user = await _auth.currentUser();
  //   db.child('User').set({
  //     'Name':userName,
  //     'Email':email
  //   });
  // }

  // void writeData() async {
  //   String email = emailController.text.trim();

  //   String userName = usernameController.text.trim();
  //   // ignore: deprecated_member_use
  //   final FirebaseUser user = await _auth.currentUser();
  //   final uid = user.uid;
  //   DB.child(uid).set(
  //     {
  //       'User Name': userName, 
  //       'Email': email
  //       });
  // }
}

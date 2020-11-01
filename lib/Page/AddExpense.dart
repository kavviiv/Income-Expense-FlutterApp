import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inandex/Page/Expense.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> with TickerProviderStateMixin {
  int _selectedIndex;
  List<String> _options = ['ค่าห้อง','ค่าอาหาร', 'ค่าเดินทาง', 'ของใช้', 'อื่นๆ'];

  Widget _buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(_options[i],
            style: TextStyle(fontSize: 20, color: Colors.white)),
        avatar: Icon(Icons.score),
        elevation: 5,
        pressElevation: 5,
        //shadowColor: Colors.teal,
        backgroundColor: Colors.grey,
        selectedColor: Colors.redAccent,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
              String selectedd = "rr";
              print(selectedd);
            }
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), child: choiceChip));
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  TextEditingController incomeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  get selectedChoice => null;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  final firestoreInstance = FirebaseFirestore.instance;
  //List<MyClass> selecteditems = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 90),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              //color: new Color(0xffffc107),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                color: Color(0xffffc107),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เลือกประเภทของรายจ่าย',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: _buildChips(),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              //color: new Color(0xffffc107),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                color: Color(0xffffc107),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'กรอกจำนวนเงิน',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 390.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, top: 20),
                      child: TextField(
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        controller: incomeController,
                        decoration: InputDecoration(
                          labelText: "กรุณาใส่จำนวนเงิน",
                          hintText: "จำนวนเงิน",
                          labelStyle:
                              // TextStyle(fontSize: 14, color: Colors.grey.shade400),
                              TextStyle(fontSize: 20, color: Colors.black),
                          hintStyle: TextStyle(fontSize: 20),
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
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Center(
              child: Container(
                  padding: EdgeInsets.only(top: 0),
                  width: 390,
                  height: 52,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                        side: BorderSide(color: Colors.black)),
                    onPressed: () => {_onPressed()},
                    color: Colors.black,
                    child: Text(
                      'บันทึก',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _onPressed() {
    if (_selectedIndex == 0) {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      final String datte = formatted;
      print(datte);
      String ty = "เงินเดือน";
      String money = incomeController.text.trim();
      var firebaseUser = FirebaseAuth.instance.currentUser;
      firestoreInstance
          .collection(firebaseUser.uid)
          .doc("รายจ่าย")
          .collection("รายจ่าย")
          .add({"ประเภท": ty, "จำนวนเงิน": money, "when": datte}).then((value) {
        showAlertDialog(context);
        print("success");
      });
    }

    if (_selectedIndex == 1) {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      final String datte = formatted;
      print(datte);
      String ty = "งานพิเศษ";
      String money = incomeController.text.trim();
      var firebaseUser = FirebaseAuth.instance.currentUser;
      firestoreInstance
          .collection(firebaseUser.uid)
          .doc("รายจ่าย")
          .collection("รายจ่าย")
          .add({"ประเภท": ty, "จำนวนเงิน": money, "when": datte}).then((value) {
        showAlertDialog(context);
        print("success");
      });
    }
    if (_selectedIndex == 2) {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      final String datte = formatted;
      print(datte);
      String ty = "ขายของ";
      String money = incomeController.text.trim();
      var firebaseUser = FirebaseAuth.instance.currentUser;
      firestoreInstance
          .collection(firebaseUser.uid)
          .doc("รายจ่าย")
          .collection("รายจ่าย")
          .add({"ประเภท": ty, "จำนวนเงิน": money, "when": datte}).then((value) {
        showAlertDialog(context);
        print("success");
      });
    }
    if (_selectedIndex == 3) {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      final String datte = formatted;
      print(datte);
      String ty = "อื่นๆ";
      String money = incomeController.text.trim();
      var firebaseUser = FirebaseAuth.instance.currentUser;
      firestoreInstance
          .collection(firebaseUser.uid)
          .doc("รายจ่าย")
          .collection("รายจ่าย")
          .add({"ประเภท": ty, "จำนวนเงิน": money, "when": datte}).then((value) {
        showAlertDialog(context);
        print("success");
      });
    }
 
  }
}





showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("ตกลง"),
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ExpensePage();
      }));
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("บันทึกข้อมูลสำเร็จ"),
    content: Text("บันทึกข้อมูลของคุณสำเร็จแล้ว กดตกลงเพื่อดำเนินการต่อ"),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:inandex/Page/Income.dart';
import 'package:flutter/services.dart';

class AddInPage extends StatefulWidget {
  @override
  _AddInPageState createState() => _AddInPageState();
  bool isDelete = true;
  bool isSelected = false;
}

class _AddInPageState extends State<AddInPage> {
  DateTime selectedDate = DateTime.now();

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

  List<String> chipList = [
    "เงินเดือน",
    "ขายของ",
    "OT",
    "งานพิเศษ",
    "อื่น ๆ",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Center(
            child: Container(
              width: 390,
              height: 200,
              child: Column(
                children: <Widget>[
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
                          'เลือกประเภทของรายรับ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      child: Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: <Widget>[
                      choiceChipWidget(chipList),
                    ],
                  )),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: Container(
              width: 390.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: TextField(
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
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
          ),
          SizedBox(height: 20),
          Center(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 390,
                    height: 40,
                    child: RaisedButton(
                      onPressed: () => _selectDate(context),
                      child: Text(
                        'เลือกวันที่ต้องการบันทึก',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Container(
                padding: EdgeInsets.only(top: 20),
                width: 390,
                height: 70,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      side: BorderSide(color: Colors.black)),
                  onPressed: () => {
                    savetoDb()
                  },
                  color: Colors.black,
                  child: Text(
                    'บันทึก',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

savetoDb() {
  
}

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(5.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: Color(0xffffc107),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

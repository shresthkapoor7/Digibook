import 'package:digibook/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Homepage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:page_transition/page_transition.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

DateTime _dateTime = DateTime.now();
String _date = _dateTime.day.toString() + ' ' + months[_dateTime.month - 1];
String diaryData = 'abcd';

class _DiaryPageState extends State<DiaryPage> {
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 30, left: 25, bottom: 30),
                      child: Text('Diary', style: TextStyle(fontSize: 35))),
                  Row(
                    children: [
                      Transform(
                        transform: Matrix4.translationValues(20, 0, 0),
                        child: IconButton(
                          color: Colors.black,
                          icon: Icon(
                            Icons.arrow_left,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _dateTime =
                                  _dateTime.subtract(new Duration(days: 1));
                              _date = _dateTime.day.toString() +
                                  ' ' +
                                  months[_dateTime.month - 1];
                            });
                          },
                        ),
                      ),
                      TextButton(
                        child:
                            Text(_date, style: TextStyle(color: Colors.black)),
                        onPressed: () async {
                          final DateTime _pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                            currentDate: DateTime.now(),
                            initialDate: DateTime.now(),
                          );
                          if (_pickedDate != null && _pickedDate != _dateTime) {
                            setState(() {
                              _dateTime = _pickedDate;
                              _date = _dateTime.day.toString() +
                                  ' ' +
                                  months[_dateTime.month - 1];
                            });
                          }
                        },
                      ),
                      Transform(
                        transform: Matrix4.translationValues(-20, 0, 0),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_right,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _dateTime = _dateTime.add(new Duration(days: 1));
                              _date = _dateTime.day.toString() +
                                  ' ' +
                                  months[_dateTime.month - 1];
                            });
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                  height: height - 270,
                  width: width - 30,
                  child: Card(
                    color: Colors.white,
                    elevation: 8,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: FutureBuilder(
                                builder: (context, _getData) {
                                  return Text(diaryData);
                                },
                                future: _getData(),
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20, right: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    primary: Colors.white,
                                    elevation: 8),
                                child: Container(
                                  height: 45,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          duration: Duration(milliseconds: 400),
                                          child: EditText(
                                            textFieldData: diaryData,
                                          )));
                                },
                              ),
                            ))
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> _getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  diaryData = prefs.getString(_date + "diary") ?? ' ';
  return diaryData;
}

class EditText extends StatefulWidget {
  final String textFieldData;

  const EditText({Key key, this.textFieldData}) : super(key: key);
  @override
  EditTextState createState() => EditTextState();
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final RoundedLoadingButtonController _btnController =
        new RoundedLoadingButtonController();
    String data;
    bool _saved = false;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(_date, style: TextStyle(fontSize: 30)),
              SizedBox(
                height: 30,
              ),
              _textField(
                  textFieldData: widget.textFieldData,
                  height: height - 360,
                  width: width - 30),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: (!_saved)
                      ? RaisedButton(
                          color: Colors.blue,
                          child: Container(
                            height: 50,
                            width: 100,
                            child: Center(
                              child: Text("Save",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          onPressed: () {
                            setState(() async {
                              _saved = true;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(_date + "diary", _tempData);
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: NavBar()));
                            });
                          },
                        )
                      : Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
      ),
    );
  }
}

String _tempData;
Widget _textField(
    {bool obscure = false,
    String textFieldData,
    TextInputType input = TextInputType.multiline,
    double height = 50,
    double width = 200}) {
  return Container(
    height: height,
    width: width,
    padding: EdgeInsets.only(left: 20),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      boxShadow: [
        BoxShadow(
          color: Colors.grey[400],
          offset: Offset(5.0, 5.0),
          blurRadius: 5.0,
          spreadRadius: 2,
        ),
      ],
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    child: TextFormField(
      obscureText: obscure,
      keyboardType: input,
      initialValue: textFieldData,
      maxLines: null,
      decoration: InputDecoration(border: InputBorder.none),
      onChanged: (value) {
        _tempData = value;
      },
    ),
  );
}

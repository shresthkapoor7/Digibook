import 'package:digibook/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemindersPage extends StatefulWidget {
  @override
  _RemindersPageState createState() => _RemindersPageState();
}

List<String> remindersHeader = [''];
List<String> remindersTime = [''];
List<String> remindersDate = [''];

class _RemindersPageState extends State<RemindersPage> {
  void initState() {
    super.initState();
    //destroyData();
  }

  void destroyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('RemindersHeader', ['']);
    prefs.setStringList('RemindersTime', ['']);
    prefs.setStringList('RemindersDate', ['']);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            } else if (!snapshot.hasData) {
              return SafeArea(
                child: Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "No Reminders",
                          style: TextStyle(
                              color: Colors.grey, fontSize: width * 0.1),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: width / 3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              padding: EdgeInsets.all(12)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddReminder()));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.blue,
                              ),
                              Text(
                                "Add a reminder",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SafeArea(
                child: Scaffold(
                    body: (remindersHeader.length <= 1)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "No Reminders",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: width * 0.1),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: width / 3,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      padding: EdgeInsets.all(12)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReminder()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "Add a reminder",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                "Reminders",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width * 0.09),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: remindersHeader.length - 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      width: width,
                                      child: Card(
                                        elevation: 8,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: remindersHeader[
                                                          index + 1] +
                                                      '\n',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: width * 0.05)),
                                              TextSpan(
                                                  text:
                                                      remindersDate[index + 1] +
                                                          '\n',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: width * 0.04)),
                                              TextSpan(
                                                  text:
                                                      remindersTime[index + 1] +
                                                          '\n',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: width * 0.04))
                                            ]),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      elevation: 8,
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(12)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReminder()));
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          )),
              );
            }
          },
          future: _getData(),
        ));
  }
}

Future<String> _getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  remindersHeader = prefs.getStringList('RemindersHeader');
  remindersDate = prefs.getStringList('RemindersDate');
  remindersTime = prefs.getStringList('RemindersTime');
  return remindersHeader[0];
}

class AddReminder extends StatefulWidget {
  DateTime _dateTime;
  TimeOfDay _timeOfDay;
  String _header;
  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: SafeArea(
          child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add a reminder",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.06),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name of reminder",
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget._header = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "    Date\n",
                        style: TextStyle(fontSize: width * 0.04),
                      ),
                      Container(
                        width: width / 3,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: TextButton(
                          onPressed: () async {
                            var _date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100));
                            if (_date != null) {
                              setState(() {
                                widget._dateTime = _date;
                              });
                            }
                          },
                          child: Text(
                            (widget._dateTime == null)
                                ? "Date"
                                : widget._dateTime.day.toString() +
                                    ' ' +
                                    months[widget._dateTime.month - 1],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "    Time\n",
                        style: TextStyle(fontSize: width * 0.04),
                      ),
                      Container(
                        width: width / 3,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: TextButton(
                          onPressed: () async {
                            var _time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 12, minute: 12));
                            if (_time != null) {
                              setState(() {
                                widget._timeOfDay = _time;
                              });
                            }
                          },
                          child: Text(
                            (widget._timeOfDay == null)
                                ? "Time"
                                : (widget._timeOfDay.hour.toString() +
                                    ':' +
                                    widget._timeOfDay.minute.toString()),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    print(widget._dateTime);
                    print(widget._timeOfDay);
                    print(widget._header);
                    if (widget._dateTime != null &&
                        widget._timeOfDay != null &&
                        widget._header != null) {
                      setState(() {
                        remindersHeader.add(widget._header);
                        remindersDate.add(
                          widget._dateTime.day.toString() +
                              ' ' +
                              months[widget._dateTime.month - 1],
                        );
                        remindersTime.add(widget._timeOfDay.hour.toString() +
                            ':' +
                            widget._timeOfDay.minute.toString());
                      });
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setStringList('RemindersHeader', remindersHeader);
                      prefs.setStringList('RemindersDate', remindersDate);
                      prefs.setStringList('RemindersTime', remindersTime);
                      Navigator.pop(context);
                    } else {
                      showAlertDialog(
                          context, 'Please fill out all the details');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  child: Container(
                      width: 150,
                      height: 50,
                      child: Center(
                          child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.black, fontSize: width * 0.05),
                      ))),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

showAlertDialog(BuildContext context, String message) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(message),
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

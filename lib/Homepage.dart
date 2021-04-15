import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

int heightinM = 0, weight = 0;
double BMI = 0;

List months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];
DateTime _dateTime = DateTime.now();
String _date = _dateTime.day.toString() + ' ' + months[_dateTime.month - 1];

List<String> images = [
  'assets/Images/breakfast.png',
  'assets/Images/lunch.png',
  'assets/Images/dinner.png',
];

List<String> timeOfMeal = ['Breakfast', 'Lunch', 'Dinner'];

List<List<String>> meal = [
  ['Bread', 'Eggs', 'Pancakes', '555'],
  ['Chappati', 'Rice', '1000'],
  ['Pizza', 'Burger', 'Steak', '1200']
];

List<List<Color>> colors = [
  [HexColor('#FF8492'), HexColor('#7D77FF')],
  [HexColor('#3499FF'), HexColor('#3A3985')],
  [
    Colors.brown[400],
    Colors.brown[800],
  ]
];

List<Color> shadowColors = [Colors.pink, Colors.blue, Colors.brown];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [HexColor('#fffcff'), HexColor('#d5fefd')])),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25, bottom: 30),
                    child: Text("Your Diet",
                        style: TextStyle(
                            fontSize: width * 0.09,
                            fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        'Meals today',
                        style: TextStyle(fontSize: 25),
                      )),
                  Container(
                    height: height / 3 + 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: timeOfMeal.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Container(
                            height: height / 3 + 20,
                            width: width / 3 + 40,
                            child: TextButton(
                              onPressed: () {
                                showAlertDialog(context, index);
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 25),
                                    child: Container(
                                      height: height / 3,
                                      child: Card(
                                        elevation: 8,
                                        shadowColor: shadowColors[index],
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 70, right: 20),
                                                  child: RichText(
                                                    text: TextSpan(
                                                        //style: DefaultTextStyle.of(context).style,
                                                        children: [
                                                          TextSpan(
                                                              text: timeOfMeal[
                                                                      index] +
                                                                  '\n' +
                                                                  '\n',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)),
                                                          for (int c = 0;
                                                              c <
                                                                  meal[index]
                                                                          .length -
                                                                      1;
                                                              c++)
                                                            TextSpan(
                                                                text:
                                                                    meal[index][
                                                                            c] +
                                                                        '\n',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          TextSpan(
                                                              text: '\n' +
                                                                  meal[index][
                                                                      meal[index]
                                                                              .length -
                                                                          1],
                                                              style: TextStyle(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                          TextSpan(
                                                              text: ' kcal',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                              ))
                                                        ]),
                                                  )),
                                            ],
                                          ),
                                          // height:
                                          //     MediaQuery.of(context).size.height / 3,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3 +
                                              30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(100),
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              gradient: LinearGradient(
                                                colors: colors[index],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(100),
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Image.asset(
                                      images[index].toString(),
                                      scale: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Container(
                      width: width - 50,
                      height: height / 6,
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    HexColor('#FFA62E'),
                                    HexColor('#EA4D2C').withOpacity(0.9)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 30, right: 20, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("BMI",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.08,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                      BMI.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.08,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          width: width / 4,
                                          height: width * 0.1,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                weight = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Weight(in KG)"),
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          width: width / 4,
                                          height: width * 0.1,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                heightinM = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Height(in CM)"),
                                          )),
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Check',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          BMI = ((weight /
                                                  (heightinM * heightinM)) *
                                              10000);
                                          BMI =
                                              num.parse(BMI.toStringAsFixed(2));
                                          BMI = ((weight /
                                                  (heightinM * heightinM)) *
                                              10000);
                                          BMI =
                                              num.parse(BMI.toStringAsFixed(2));
                                        });
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            )),
      ),
    );
  }

  showAlertDialog(BuildContext context, int time) {
    String meal1 = '';
    String meal2 = '';
    String meal3 = '';
    String calories = '';
    Widget okButton = FlatButton(
      child: Text(
        "Ok",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        if (meal1.length + meal2.length + meal3.length != 0 && calories != '') {
          setState(() {
            meal[time] = [meal1, meal2, meal3, calories];
          });
        }
        Navigator.pop(context);
      },
    );
    Widget textField1 = TextFormField(
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(hintText: "Meal 1"),
      onChanged: (value) {
        setState(() {
          meal1 = value;
        });
      },
    );
    Widget textField2 = TextFormField(
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(hintText: "Meal 2"),
      onChanged: (value) {
        setState(() {
          meal2 = value;
        });
      },
    );

    Widget textField3 = TextFormField(
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(hintText: "Meal 3"),
      onChanged: (value) {
        setState(() {
          meal3 = value;
        });
      },
    );

    Widget textField4 = TextFormField(
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(hintText: "Total Calories"),
        onChanged: (value) {
          setState(() {
            calories = value;
          });
        });

    AlertDialog alert = AlertDialog(
      title: Text(timeOfMeal[time], style: TextStyle(color: Colors.black)),
      content: Column(
        children: [
          textField1,
          textField2,
          textField3,
          textField4,
        ],
      ),
      actions: [
        okButton,
      ],
      backgroundColor: Colors.white,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
      barrierDismissible: true,
    );
  }
}

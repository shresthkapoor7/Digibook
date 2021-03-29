import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

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

List<List<String>> meal = [
  ['Breafast', 'Bread', 'Eggs', 'Pancakes', '555'],
  ['Lunch', 'Chappati', 'Rice', 'Dal', '1000'],
  ['Dinner', 'Pizza', 'Burger', 'Steak', '1200']
];

List<List<Color>> colors = [
  [
    Colors.pink[200],
    Colors.pink[100],
  ],
  [Colors.blue[200], Colors.blue],
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25, bottom: 30),
                child: Text("Your Diet", style: TextStyle(fontSize: 25)),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 25, top: 30),
                  child: Text(
                    'Meals today',
                    style: TextStyle(fontSize: 25),
                  )),
              Container(
                height: height / 3 + 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Container(
                        height: height / 3 + 20,
                        width: width / 3 + 40,
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
                                                        text: meal[index][0] +
                                                            '\n' +
                                                            '\n',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                    TextSpan(
                                                        text: meal[index][1] +
                                                            '\n' +
                                                            meal[index][2] +
                                                            '\n' +
                                                            meal[index][3] +
                                                            '\n\n',
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                        )),
                                                    TextSpan(
                                                        text: meal[index][4],
                                                        style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        )),
                                                    TextSpan(
                                                        text: ' kcal',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                        ))
                                                  ]),
                                            )),
                                      ],
                                    ),
                                    // height:
                                    //     MediaQuery.of(context).size.height / 3,
                                    width:
                                        MediaQuery.of(context).size.width / 3 +
                                            30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(100),
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
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
                    );
                  },
                ),
              )
            ],
          ))),
    );
  }
}

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:digibook/Diary.dart';
import 'package:digibook/Reminders.dart';
import 'package:digibook/Shopping.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Homepage.dart';

class NavBar extends StatefulWidget {
  final int index;

  const NavBar({Key key, this.index = 0}) : super(key: key);
  @override
  _NavBarState createState() => _NavBarState();
}

int _bottomIndex = 0;
List<List<Color>> backgroundColors = [
  [HexColor('#fffcff'), HexColor('#d5fefd')],
  [HexColor('#6e45e1'), HexColor('#89d4cf')],
  [HexColor('#fbd72b'), HexColor('#f9484a')],
  [HexColor('#2e1f3c'), HexColor('#db3d75')],
];
int _activeColor = 0;

class _NavBarState extends State<NavBar> {
  void initState() {
    super.initState();
    _bottomIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: backgroundColors[_activeColor]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0))),
          child: AnimatedBottomNavigationBar(
            icons: [
              Icons.healing,
              Icons.book,
              Icons.list,
              Icons.person,
            ],
            backgroundColor: Colors.transparent,
            gapLocation: GapLocation.none,
            elevation: 0,
            activeIndex: _bottomIndex,
            notchSmoothness: NotchSmoothness.smoothEdge,
            inactiveColor: (_bottomIndex == 0) ? Colors.black : Colors.white,
            splashColor: Colors.blue[900],
            activeColor: (_bottomIndex == 0)
                ? Colors.blue
                : backgroundColors[_activeColor][0],
            onTap: ((index) {
              if (index != _bottomIndex) {
                setState(() {
                  _bottomIndex = index;
                  _activeColor = index;
                });
              }
            }),
          ),
        ),
        body: (_bottomIndex == 0)
            ? HomePage()
            : (_bottomIndex == 1)
                ? DiaryPage()
                : (_bottomIndex == 2)
                    ? ShowShoppingList()
                    : RemindersPage());
  }
}

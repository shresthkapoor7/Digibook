import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:digibook/Diary.dart';
import 'package:digibook/Reminders.dart';
import 'package:digibook/Shopping.dart';
import 'package:flutter/material.dart';
import 'Homepage.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

int _bottomIndex = 0;

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
            inactiveColor: Colors.black,
            splashColor: Colors.blue[900],
            // leftCornerRadius: 20,
            // rightCornerRadius: 20,
            activeColor: Colors.blue[900],
            onTap: ((index) {
              if (index != _bottomIndex) {
                setState(() {
                  _bottomIndex = index;
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

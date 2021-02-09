import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [Icons.healing, Icons.book, Icons.list, Icons.person],
        gapLocation: GapLocation.center,
        activeIndex: _bottomIndex,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        onTap: ((index){
          setState(() {
            _bottomIndex = index;
          });
        }),
      ),
      body: (_bottomIndex==0)? HomePage(): Center(child: Text('Another page'),)
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

List<bool> _checkBoxValues = new List<bool>.filled(1000, false, growable: true);

class _ShoppingListState extends State<ShoppingList> {
  void initState() {
    super.initState();
    _setDetails();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Container(
        // height: height,
        width: width - 20,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child:
                    Text("Your Shopping List", style: TextStyle(fontSize: 40))),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Card(
                  elevation: 8,
                  child: FutureBuilder(
                    builder: (context, data) {
                      if (data.connectionState == ConnectionState.none) {
                        return Text("SOME ERROR OCCURED");
                      } else if (data.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      return ListView.builder(
                        itemCount:
                            (shoppingList == null) ? 0 : shoppingList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Checkbox(
                              value: _checkBoxValues[index],
                              onChanged: (value) {
                                setState(() {
                                  _checkBoxValues[index] = value;
                                });
                              },
                            ),
                            title: Text(
                              shoppingList[index].toString(),
                              style: TextStyle(
                                fontSize: 20,
                                decoration: (_checkBoxValues[index])
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    future: _getDetails(),
                  )),
            ),
          ],
        ),
      )),
    ));
  }
}

List<String> shoppingList = ['NO DATA'];
List<String> temp = [];
void _setDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('key', null);
}

Future<List> _getDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  shoppingList = prefs.getStringList('key');
  return shoppingList;
}

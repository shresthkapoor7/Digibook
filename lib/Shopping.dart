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
      backgroundColor: Colors.black87,
      body: Center(
          child: Container(
        height: height - 200,
        width: width - 30,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child:
                    Text("Your Shopping List", style: TextStyle(fontSize: 40))),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Card(
                  color: Colors.black26,
                  elevation: 8,
                  child: FutureBuilder(
                    builder: (context, data) {
                      // if (data.connectionState == ConnectionState.none) {
                      //   return Text("SOME ERROR OCCURED");
                      // } else if (data.connectionState ==
                      //     ConnectionState.waiting) {
                      //   return CircularProgressIndicator();
                      // }
                      return ListView.builder(
                        itemCount:
                            (shoppingList == null) ? 0 : shoppingList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Theme(
                                child: Checkbox(
                                  value: _checkBoxValues[index],
                                  onChanged: (value) {
                                    setState(() {
                                      _checkBoxValues[index] = value;
                                    });
                                  },
                                ),
                                data: ThemeData(
                                  primarySwatch: Colors.blue,
                                  unselectedWidgetColor: Colors.white,
                                )),
                            title: Text(
                              shoppingList[index].toString(),
                              style: TextStyle(
                                color: Colors.white,
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
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 25, right: 5),
                child: ButtonTheme(
                  height: 50,
                  child: RaisedButton(
                    elevation: 8,
                    onPressed: () {},
                    child: Icon(
                      Icons.add,
                      color: Colors.blue,
                      size: 30,
                    ),
                    shape: CircleBorder(),
                    color: Colors.grey[900],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    ));
  }
}

List<String> shoppingList = ['This', 'is', 'a', 'Shopping list'];
void _setDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('key', shoppingList);
}

Future<List> _getDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  shoppingList = prefs.getStringList('key');
  return shoppingList;
}

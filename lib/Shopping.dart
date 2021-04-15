import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

String newItem;

List<String> shoppingListItems = [''];
List<bool> shoppingListItemsBool = [];

class ShowShoppingList extends StatefulWidget {
  @override
  _ShowShoppingListState createState() => _ShowShoppingListState();
}

void _setData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('Shopping List', shoppingListItems);
}

Future<String> _getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  shoppingListItems = prefs.getStringList('Shopping List');
  if (shoppingListItems == null) {
    shoppingListItems = [''];
    return null;
  }
  for (int c = 0; c < shoppingListItems.length; c++) {
    shoppingListItemsBool.add(false);
  }
  return shoppingListItems[0];
}

void destroyData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('Shopping List', ['']);
}

class _ShowShoppingListState extends State<ShowShoppingList> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [HexColor('#fbd72b'), HexColor('#f9484a')])),
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
            child: Container(
                height: height - 200,
                width: width - 30,
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Stack(
                      children: [
                        (shoppingListItems == null)
                            ? Container()
                            : Align(
                                alignment: Alignment.topCenter,
                                child: Text("Shopping List",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold))),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Container(
                            child: ListView.builder(
                              itemCount: shoppingListItems == null
                                  ? 0
                                  : shoppingListItems.length - 1,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Theme(
                                      child: Checkbox(
                                        focusColor: Colors.white,
                                        activeColor: Colors.yellow[900],
                                        value: shoppingListItemsBool[index + 1],
                                        onChanged: (value) {
                                          setState(() {
                                            shoppingListItemsBool[index + 1] =
                                                value;
                                          });
                                        },
                                      ),
                                      data: ThemeData(
                                        primarySwatch: Colors.blue,
                                        unselectedWidgetColor: Colors.black,
                                      )),
                                  title: Text(
                                    shoppingListItems[index + 1].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.06,
                                      decoration:
                                          (shoppingListItemsBool[index + 1] ==
                                                  true)
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25, right: 5),
                            child: ButtonTheme(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 8,
                                    shadowColor: Colors.yellow[900],
                                    shape: CircleBorder(),
                                    primary: Colors.orange,
                                    padding: EdgeInsets.all(15)),
                                onPressed: () async {
                                  showAlertDialog(context);
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  future: _getData(),
                ))),
      )),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text(
        "Ok",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        setState(() {
          shoppingListItems.add(newItem);
          shoppingListItemsBool.add(false);
          newItem = null;
        });
        print(shoppingListItems);
        _setData();
        Navigator.pop(context);
      },
    );
    Widget textField = TextFormField(
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(color: Colors.black),
      onChanged: (value) {
        setState(() {
          newItem = value;
        });
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Add an item", style: TextStyle(color: Colors.white)),
      content: textField,
      actions: [
        okButton,
      ],
      backgroundColor: Colors.yellow[800],
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

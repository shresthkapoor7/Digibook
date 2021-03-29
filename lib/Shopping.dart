import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ShoppingList extends StatefulWidget {
//   @override
//   _ShoppingListState createState() => _ShoppingListState();
// }

// List<String> _checkBoxValues =
//     new List<String>.filled(1000, 'false', growable: true);

// class _ShoppingListState extends State<ShoppingList> {
//   void initState() {
//     super.initState();
//     _setDetails();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return SafeArea(
//         child: Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.grey[200],
//       body: Center(
//           child: Container(
//         height: height - 200,
//         width: width - 30,
//         child: Stack(
//           children: [
//             Align(
//                 alignment: Alignment.topCenter,
//                 child:
//                     Text("Your Shopping List", style: TextStyle(fontSize: 40))),
//             Padding(
//               padding: EdgeInsets.only(top: 50),
//               child: Card(
//                   color: Colors.white,
//                   elevation: 8,
//                   child: FutureBuilder(
//                     builder: (context, data) {
//                       return ListView.builder(
//                         itemCount:
//                             (shoppingList == null) ? 0 : shoppingList.length,
//                         scrollDirection: Axis.vertical,
//                         itemBuilder: (BuildContext context, int index) {
//                           return ListTile(
//                             leading: Theme(
//                                 child: Checkbox(
//                                   value: _checkBoxValues[index] == 'false'
//                                       ? false
//                                       : true,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _checkBoxValues[index] = value.toString();
//                                     });
//                                     _setDetails();
//                                   },
//                                 ),
//                                 data: ThemeData(
//                                   primarySwatch: Colors.blue,
//                                   unselectedWidgetColor: Colors.white,
//                                 )),
//                             title: Text(
//                               shoppingList[index].toString(),
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 decoration: (_checkBoxValues[index] == 'true')
//                                     ? TextDecoration.lineThrough
//                                     : TextDecoration.none,
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     future: _getDetails(),
//                   )),
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: EdgeInsets.only(bottom: 25, right: 5),
//                 child: ButtonTheme(
//                   height: 50,
//                   child: RaisedButton(
//                     elevation: 8,
//                     onPressed: () async {
//                       showAlertDialog(context);
//                       setState(() {
//                         if (newItem != null) {
//                           shoppingList.add(newItem);
//                         }
//                         newItem = null;
//                       });
//                       await _setDetails();
//                       await _getDetails();
//                     },
//                     child: Icon(
//                       Icons.add,
//                       color: Colors.blue,
//                       size: 30,
//                     ),
//                     shape: CircleBorder(),
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       )),
//     ));
//   }
// }

//
// List<String> shoppingList = ['Shopping list'];
// Future<void> _setDetails() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setStringList('Shopping List', shoppingList);
//   prefs.setStringList('Shopping List Bool', _checkBoxValues);
// }

// Future<List> _getDetails() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   shoppingList = prefs.getStringList('Shopping List');
//   _checkBoxValues = prefs.getStringList('Shopping List Bool');
//   return shoppingList;
// }

String newItem;

List<String> shoppingListItems = ['Shopping List'];
List<bool> shoppingListItemsBool = [false];

class ShowShoppingList extends StatefulWidget {
  @override
  _ShowShoppingListState createState() => _ShowShoppingListState();
}

class _ShowShoppingListState extends State<ShowShoppingList> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
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
                color: Colors.white,
                elevation: 8,
                child: ListView.builder(
                  itemCount: (shoppingListItems == null)
                      ? 0
                      : shoppingListItems.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Theme(
                          child: Checkbox(
                            value: shoppingListItemsBool[index],
                            onChanged: (value) {
                              setState(() {
                                shoppingListItemsBool[index] = value;
                              });
                            },
                          ),
                          data: ThemeData(
                            primarySwatch: Colors.blue,
                            unselectedWidgetColor: Colors.black,
                          )),
                      title: Text(
                        shoppingListItems[index].toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          decoration: (shoppingListItemsBool[index] == true)
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
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 25, right: 5),
                child: ButtonTheme(
                  height: 50,
                  child: RaisedButton(
                    elevation: 8,
                    onPressed: () async {
                      showAlertDialog(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.blue,
                      size: 30,
                    ),
                    shape: CircleBorder(),
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    ));
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        setState(() {
          shoppingListItems.add(newItem);
          shoppingListItemsBool.add(false);
          newItem = null;
        });
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
      title: Text("Add an item", style: TextStyle(color: Colors.black)),
      content: textField,
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

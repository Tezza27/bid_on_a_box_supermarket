import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/colours.dart';

class AddItem extends StatelessWidget {
  final String title,
      description,
      itemInput,
      cancelButton,
      addButton,
      finishButton,
      cancelButtonText,
      addButtonText,
      finishButtonText,
      cancelRoute,
      addRoute,
      finishRoute;

  AddItem(
      {Key key,
      this.title,
      this.description,
      this.itemInput,
      this.cancelButton,
      this.addButton,
      this.finishButton,
      this.cancelButtonText,
      this.addButtonText,
      this.finishButtonText,
      this.cancelRoute,
      this.addRoute,
      this.finishRoute})
      : super(key: key);

  static const double padding = 20.0;
  TextEditingController _itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(padding)),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(padding),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ]),
            child: Column(
              children: <Widget>[
                SizedBox(height: 24.0),
                Text(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                Text(
                  description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _itemController,
                  decoration: InputDecoration(
                      labelText: itemInput,
                      hintText: "Enter product",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                SizedBox(height: 24.0),
                Row(
                  children: <Widget>[
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(cancelButtonText),
                        onPressed: null),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(addButtonText),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacementNamed(addRoute);
                        }),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(finishButtonText),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed(finishRoute);
                        }),
                  ],
                ),
                SizedBox(height: 24.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}

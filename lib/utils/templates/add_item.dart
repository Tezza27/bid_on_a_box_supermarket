import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/colours.dart';

class AddItem extends StatefulWidget {
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

  static const double padding = 8.0;

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddItem.padding)),
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(AddItem.padding),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(AddItem.padding),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      offset: const Offset(0.0, 20.0),
                    ),
                  ]),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 24.0),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _itemController,
                    decoration: InputDecoration(
                        labelText: "Enter product",
                        hintText: "Enter product",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  SizedBox(height: 12.0),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Text("Clear"),
                            onPressed:
                        _clearEntry),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Text("Add item"),
                            onPressed: () {
                              _clearEntry();
                            }),
                      ),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Text("Finish"),
                          onPressed: () {
                            _clearEntry();
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacementNamed(widget.finishRoute);
                          }),

                  SizedBox(height: 12.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
String _addToList(){

}
  String _clearEntry (){
setState(() {
  _itemController.text="";
});
  }
}



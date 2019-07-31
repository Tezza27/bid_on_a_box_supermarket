import 'package:flutter/material.dart';
import 'history_screen.dart';
import './utils/colours.dart';

class NewLotScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewLotState();
  }
}

class _NewLotState extends State<NewLotScreen> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Bid-on-a-Box New Lot")),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(children: <Widget>[
                    Container(
                      height: 200.0,
                      color: accent_01Color,
                      child: Center(
                        child: Container(
                          child: Icon(Icons.camera_enhance, size: 30),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLength: 140,
                        maxLines: null,
                        controller: descriptionController,
                        decoration: InputDecoration(
                            labelText: "Lot Description",
                            hintText:
                                "Provide a general description of the contents",
                            //labelStyle: ,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    RaisedButton(
                        child: Text("Go To History Page"),
                        onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryScreen()));
                    }),
                  ]))),
        ));
  }
}

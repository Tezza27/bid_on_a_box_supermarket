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
  var _boxContentsTypes = [
    "Ambient Grocery",
    "Butchery",
    "Chilled",
    "Dairy",
    "Deli",
    "Fruit",
    "Fruit & Veg",
    "Mixed",
    "Mystery",
    "Veg"
  ];
  var _charityNames = [
    "None",
    "Charity 1",
    "Charity 2",
    "Charity 3",
    "Charity 4",
    "Charity 5",
    "Charity 6",
    "Charity 7",
    "Charity 8",
    "Charity 9",
    "Charity 10"
  ];
  var _currentBoxTypeSelected = "";
  var _currentCharityNameSelected = "";
  TextEditingController descriptionController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController charityPCController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentBoxTypeSelected = _boxContentsTypes[0];
    _currentCharityNameSelected = _charityNames[0];
  }

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
                    DropdownButton<String>(
                      isExpanded: true,
                      items: _boxContentsTypes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentBoxTypeSelected,
                      onChanged: (String newBoxTypeSelected) {
                        _onDropdownBoxTypeSelected(newBoxTypeSelected);
                      },
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                flex: 20,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: weightController,
                                  decoration: InputDecoration(
                                      labelText: "Box Weight in KG",
                                      hintText: "Weight in KG",
                                      //labelStyle: ,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                )),
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                            Flexible(
                                flex: 20,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: priceController,
                                  decoration: InputDecoration(
                                      labelText: "Box RRP in £",
                                      hintText: "Retail price total",
                                      //labelStyle: ,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                ))
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                flex: 20,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  items: _charityNames.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  value: _currentCharityNameSelected,
                                  onChanged: (String newCharitySelected) {
                                    _onDropdownCharitySelected(newCharitySelected);
                                  },
                                )),
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                            Flexible(
                                flex: 5,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: charityPCController,
                                  decoration: InputDecoration(
                                      labelText: "%",
                                      hintText: "%",
                                      //labelStyle: ,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                )),

                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RaisedButton(
                          child: Text("Go To History Page"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryScreen()));
                          }),
                    ),
                  ]))),
        ));
  }

  void _onDropdownBoxTypeSelected(String newBoxTypeSelected) {
    setState(() {
      this._currentBoxTypeSelected = newBoxTypeSelected;
    });
  }
  void _onDropdownCharitySelected(String newCharitySelected) {
    setState(() {
      this._currentCharityNameSelected = newCharitySelected;
    });
  }
}

import 'package:flutter/material.dart';
import 'history_screen.dart';
import './utils/colours.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class NewLotScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewLotState();
  }
}

class _NewLotState extends State<NewLotScreen> {
  var _formKey = GlobalKey<FormState>();
  DateTime _currentDate = DateTime.now();
  TimeOfDay _closingTime = TimeOfDay(hour: 21, minute: 00);
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
  DateTime closingDate;
  var _currentBoxTypeSelected = "";
  var _currentCharityNameSelected = "";
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _charityPCController = TextEditingController();
  TextEditingController _closingDateController = TextEditingController();
  TextEditingController _closingTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentBoxTypeSelected = _boxContentsTypes[0];
    _currentCharityNameSelected = _charityNames[0];
    _closingDateController.text = DateFormat('dd/MM/yy').format(_currentDate);
    //_closingTimeController.text = _closingTime.toString("HH\:mm");
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
                      //Image holder with camera icon
                      height: 200.0,
                      color: accent_01Color,
                      child: Center(
                        child: Container(
                          child: Icon(Icons.camera_enhance, size: 30),
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      //Box type selector
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
                        //Box description/notes
                        keyboardType: TextInputType.multiline,
                        maxLength: 140,
                        maxLines: null,
                        controller: _descriptionController,
                        decoration: InputDecoration(
                            labelText: "Lot Description",
                            hintText: "Provide notes/description for the lot",
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
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: TextFormField(
                                    //Box weight input field
                                    keyboardType: TextInputType.number,
                                    controller: _weightController,
                                    decoration: InputDecoration(
                                        labelText: "Box Weight in KG",
                                        hintText: "Weight in KG",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                  ),
                                )),
                            Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: TextFormField(
                                    //Box retail price input field
                                    keyboardType: TextInputType.number,
                                    controller: _priceController,
                                    decoration: InputDecoration(
                                        labelText: "Box RRP in £",
                                        hintText: "Retail price total",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                  ),
                                ))
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(children: <Widget>[
                        Flexible(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: TextFormField(
                                //Closing Date
                                keyboardType: TextInputType.datetime,
                                controller: _closingDateController,
                                decoration: InputDecoration(
                                    labelText: "Closing Date",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                            )),
                        Flexible(
                            flex: 2,
                            child: Center(
                              child: Container(
                                child: Ink(
                                  decoration: ShapeDecoration(
                                      shape: CircleBorder(),
                                      color: Theme.of(context).buttonColor),
                                  child: IconButton(
                                      icon: Icon(Icons.date_range),
                                      onPressed: null),
                                ),
                              ),
                            )),
                        Flexible(
                            flex: 4,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _closingTimeController,
                                decoration: InputDecoration(
                                    labelText: "Closing Time",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                            )),
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: Container(
                              child: Ink(
                                decoration: ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: Theme.of(context).buttonColor),
                                child: IconButton(
                                    icon: Icon(Icons.access_time),
                                    onPressed: null),
                              ),
                            ),
                          ),
                        )
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
                                  //Charity selector
                                  isExpanded: true,
                                  items: _charityNames.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  value: _currentCharityNameSelected,
                                  onChanged: (String newCharitySelected) {
                                    _onDropdownCharitySelected(
                                        newCharitySelected);
                                  },
                                )),
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                            Flexible(
                                flex: 5,
                                child: TextFormField(
                                  //Charity percentage input field
                                  keyboardType: TextInputType.number,
                                  controller: _charityPCController,
                                  decoration: InputDecoration(
                                      labelText: "%",
                                      hintText: "%",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                )),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RaisedButton(
                          //Upload lot to live auction and go to Account History Screen
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

import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/screens/history_screen.dart';
import 'package:bid_on_a_box_supermarket/utils/colours.dart';
import 'package:intl/intl.dart';
import 'package:bid_on_a_box_supermarket/utils/models/box_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class NewLotScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewLotState();
  }
}

class _NewLotState extends State<NewLotScreen> {
  final db = Firestore.instance;
  var _formKey = GlobalKey<FormState>();
  DateTime _currentDate = DateTime.now();
  DateTime closingDate;
  String _closingTime = "21:00";
  String _collectionTime = "23:00";
  var _boxContentsTypes = [
    "",
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
    "",
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
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _charityPCController = TextEditingController();
  TextEditingController _closingDateController = TextEditingController();
  TextEditingController _closingTimeController = TextEditingController();
  TextEditingController _collectionDateController = TextEditingController();
  TextEditingController _collectionTimeController = TextEditingController();

  //These account variables are being set here for testing purposes.
  //When the app is complete, they will be established as part of
  //the sign up process
  final String storeID = "0389";
  final String regionID = "South-West";
  final String storeName = "Bodmin Superstore";
  final String storeAddress1 = "Launceston Road";
  final String storeAddress2 = "";
  final String storeTown = "Bodmin";
  final String storeCounty = "Cornwall";
  final String storePostcode = "PL31 2AR";
  final String storeTelephone = "01208 261800";
  final String storeMail = "terryrees@hotmail.com";
  final String companyID = "ASD";
  final String companyName = " Asda";
  final String companyHQAddress1 = "Asda House Southbank";
  final String companyHQAddress2 = "Great Wilson St";
  final String companyHQAddress3 = "";
  final String companyHQTown = "Leeds";
  final String companyHQCounty = "West Yorkshire";
  final String companyHQPostcode = "LS11 5AD";
  final String companyContactName = "Dave Smith";
  final String companyContactTelephone = "01132 555555";
  final String companyVerifyMail = "terryrees@hotmail.com";

  @override
  void initState() {
    super.initState();
    _reset();
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
                                    onPressed: () =>
                                        _selectDate(context, whichCalendar: 1),
                                  ),
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
                                    onPressed: () =>
                                        _selectTime(context, whichTime: 1),
                                  ),
                                ),
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
                                controller: _collectionDateController,
                                decoration: InputDecoration(
                                    labelText: "Collection Date",
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
                                    onPressed: () =>
                                        _selectDate(context, whichCalendar: 2),
                                  ),
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
                                controller: _collectionTimeController,
                                decoration: InputDecoration(
                                    labelText: "Collection Time",
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
                                    onPressed: () =>
                                        _selectTime(context, whichTime: 2),
                                  ),
                                ),
                              ),
                            ))
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                flex: 6,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
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
                                        icon: Icon(Icons.info),
                                        onPressed: null),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                                flex: 2,
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
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                                //Sends the message
                                child: Text("Add Items"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                onPressed: () async {
                                  BoxClass newBox = _prepareBox();
                                  await db
                                      .collection("boxes")
                                      .add(newBox.toJson());
                                  setState(() {
                                    _reset();
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HistoryScreen()));
                                }),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: RaisedButton(
                                  //Clears the contact text field
                                  child: Text("Cancel"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  onPressed: () {
                                    setState(() {
                                      _reset();
                                    });
                                  }),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RaisedButton(
                                  //Sends the message
                                  child: Text("Upload"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  onPressed: () async {
                                    BoxClass newBox = _prepareBox();
                                    await db
                                        .collection("boxes")
                                        .add(newBox.toJson());
                                    setState(() {
                                      _reset();
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HistoryScreen()));
                                  }),
                            ),
                          ),
                        ],
                      ),
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

  void _reset() {
    _descriptionController.text = "";
    _currentBoxTypeSelected = _boxContentsTypes[0];
    _weightController.text = "";
    _priceController.text = "";
    _currentCharityNameSelected = _charityNames[0];
    _charityPCController.text = "";
    _closingDateController.text = DateFormat('dd/MM/yy').format(_currentDate);
    _closingTimeController.text = _closingTime.toString();
    _collectionDateController.text =
        DateFormat('dd/MM/yy').format(_currentDate);
    _collectionTimeController.text = _collectionTime.toString();
  }

  BoxClass _prepareBox() {
    DateTime now = DateTime.now();
    String startDate = DateFormat('dd/MM/yy').format(now);
    String startTime = DateFormat('HH:mm').format(now);
    String thisYear = now.year.toString();
    String thisMonth = now.month.toString().padLeft(2, '0');
    String thisDay = now.day.toString().padLeft(2, '0');
    String thisHour = now.hour.toString().padLeft(2, '0');
    String thisMinute = now.minute.toString().padLeft(2, '0');
    String thisSecond = now.second.toString().padLeft(2, '0');
    String _boxID =
        "$companyID$storeID$thisYear$thisMonth$thisDay$thisHour$thisMinute$thisSecond";
    return BoxClass(
        _boxID,
        _currentBoxTypeSelected,
        startDate,
        startTime,
        _closingDateController.text,
        _closingTimeController.text,
        double.parse(_priceController.text),
        _descriptionController.text,
        double.parse(_weightController.text),
        _currentCharityNameSelected,
        double.parse(_charityPCController.text));
  }

  Future<DateTime> _selectDate(BuildContext context,
      {int whichCalendar}) async {
    final DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(_currentDate.year, _currentDate.month),
      lastDate: DateTime(
          _currentDate.add(Duration(days: 366)).year, _currentDate.month),
    );
    if (datePicked != null && datePicked != _currentDate)
      setState(() {
        if (whichCalendar == 1) {
          return _closingDateController.text =
              DateFormat('dd/MM/yy').format(datePicked).toString();
        } else {
          return _collectionDateController.text =
              DateFormat('dd/MM/yy').format(datePicked).toString();
        }
      });
  }

  Future<TimeOfDay> _selectTime(BuildContext context, {int whichTime}) async {
    final TimeOfDay timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_closingTime.split(":")[0]),
          minute: int.parse(_closingTime.split(":")[1])),
    );
    if (timePicked != null && timePicked != _closingTime)
      setState(() {
        if (whichTime == 1) {
          return _closingTimeController.text =
              "${timePicked.hour}:${timePicked.minute}";
        } else {
          return _collectionTimeController.text =
              "${timePicked.hour}:${timePicked.minute}";
        }
      });
  }
}

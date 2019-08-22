import 'dart:async';
import 'dart:io';

import 'package:bid_on_a_box_supermarket/main.dart';
import 'package:bid_on_a_box_supermarket/utils/models/box_class.dart';
import 'package:bid_on_a_box_supermarket/utils/models/charity_class.dart';
import 'package:bid_on_a_box_supermarket/utils/models/item_class.dart';
import 'package:bid_on_a_box_supermarket/utils/screens/st_petrocs_society_detail.dart';
import 'package:bid_on_a_box_supermarket/utils/variables/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  var selectedType;
  var selectedCharity;

  var _currentBoxTypeSelected = "";
  var _currentCharityNameSelected = "";
  CharityClass selectedCharityObject;
  List<String> listStringItems = [];

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _charityPCController = TextEditingController();
  TextEditingController _closingDateController = TextEditingController();
  TextEditingController _closingTimeController = TextEditingController();
  TextEditingController _collectionDateController = TextEditingController();
  TextEditingController _collectionTimeController = TextEditingController();
  TextEditingController _itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reset();
  }

  File _storedImage;
  var imageURL;

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
                      height: 200,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                      //I wanted to have some backup images representing each of the categories, which would
                      // automatically load from Firebase if a photograph wasn't provided.  I was unable to get as far as that.
                      child: _storedImage != null
                          ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            _storedImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ))
                          : Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 85.0, bottom: 85.0),
                          child: Container(
                            child: Icon(Icons.camera_enhance, size: 30),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: RaisedButton.icon(
                                  label: Text(""),
                                  icon: Icon(Icons.attach_file, size: 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30.0)),
                                  onPressed: _getPicture),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RaisedButton.icon(
                                  label: Text(""),
                                  icon: Icon(Icons.camera_enhance, size: 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30.0)),
                                  onPressed: _takePicture),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Theme
                                .of(context)
                                .buttonColor),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection("boxTypes").orderBy(
                                "type", descending: false)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: Column(
                                    children: <Widget>[
                                      Text("Loading data..."),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 32.0),
                                        child: LinearProgressIndicator(),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                List<DropdownMenuItem> typeItems = [];
                                for (int i = 0;
                                i < snapshot.data.documents.length;
                                i++) {
                                  DocumentSnapshot typeSnap =
                                  snapshot.data.documents[i];
                                  typeItems.add(DropdownMenuItem(
                                    child: Text(
                                        "${typeSnap.data["type"].toString()}"),
                                    value: "${typeSnap.data["type"]
                                        .toString()}",
                                  ));
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8.0),
                                  child: DropdownButton(
                                    // ignore: missing_return
                                    items: typeItems,
                                    isExpanded: true,
                                    underline: null,
                                    hint: Text("Select a box type"),
                                    onChanged: (typeValue) {
                                      setState(() {
                                        selectedType = typeValue;
                                      });
                                    },
                                    value: selectedType,
                                  ),
                                );
                              }
                            }),
                      ),
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
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Theme.of(context).buttonColor)),
                        ),
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
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(5.0),
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .buttonColor)),
                                    ),
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
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(5.0),
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .buttonColor)),
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
                                controller: _closingDateController,
                                decoration: InputDecoration(
                                  labelText: "Closing Date",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                          color:
                                          Theme
                                              .of(context)
                                              .buttonColor)),
                                ),
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
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                          color:
                                          Theme
                                              .of(context)
                                              .buttonColor)),
                                ),
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
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                          color:
                                          Theme
                                              .of(context)
                                              .buttonColor)),
                                ),
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
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                          color:
                                          Theme
                                              .of(context)
                                              .buttonColor)),
                                ),
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
                                child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                      Border.all(color: Theme
                                          .of(context)
                                          .buttonColor),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: Firestore.instance
                                          .collection("charities").orderBy(
                                          "charityName", descending: false)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: Column(
                                              children: <Widget>[
                                                Text("Loading data..."),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(top: 32.0),
                                                  child: LinearProgressIndicator(),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          List<
                                              DropdownMenuItem> charityItems = [
                                          ];
                                          for (int i = 0;
                                          i < snapshot.data.documents.length;
                                          i++) {
                                            DocumentSnapshot charitySnap =
                                            snapshot.data.documents[i];
                                            if (charitySnap
                                                .data["charityName"] ==
                                                selectedCharity) {
                                              selectedCharityObject =
                                                  _getCharityObject(
                                                      charitySnap);
                                            };

                                            charityItems.add(DropdownMenuItem(

                                              child: Text(
                                                  "${charitySnap
                                                      .data["charityName"]
                                                      .toString()}"),
                                              value: "${charitySnap
                                                  .data["charityName"]
                                                  .toString()}",
                                            ));
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0, left: 8.0),
                                            child: DropdownButton(
                                              // ignore: missing_return
                                              items: charityItems,
                                              isExpanded: true,
                                              underline: null,
                                              hint: Text("Select a charity"),
                                              onChanged: (charityValue) {
                                                setState(() {
                                                  selectedCharity =
                                                      charityValue;
                                                });
                                              },
                                              value: selectedCharity,
                                            ),
                                          );
                                        }
                                      }),
                                ),),
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
                                      onPressed: () {
                                        Navigator.push(

                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>

                                                    StPetrocsSocietyScreen()));
                                      },),
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
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color:
                                            Theme
                                                .of(context)
                                                .buttonColor)),
                                  ),
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
                                onPressed: () {
                                  _inputItemsDialog();
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listStringItems.length, //boxList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              key: Key(listStringItems[index]),
                              onDismissed: (direction) {
                                String removedItem =
                                    "${listStringItems[index]}";
                                setState(() {
                                  listStringItems.removeAt(index);
                                });
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Theme.of(context).hintColor,
                                  duration: Duration(milliseconds: 750),
                                  content: Text(
                                    "You have removed ${removedItem.toUpperCase()} from the list",
                                    style: Theme.of(context).textTheme.body2,
                                  ),
                                ));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 4.0,
                                borderOnForeground: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${listStringItems[index]}",
                                      style: Theme.of(context).textTheme.body1),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 24.0),
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
                                    BoxClass newBox = await _prepareBox();
                                    await db
                                        .collection("boxes")
                                        .add(newBox.toJson());

                                    String _boxID = newBox.boxID;
                                    int i = 0;
                                    for (String item in listStringItems) {
                                      ItemClass newItem = _prepareItem(
                                          boxID: _boxID,
                                          itemName: item,
                                          index: i);
                                      await db
                                          .collection("items")
                                          .add(newItem.toJson());
                                      i++;
                                    }
                                    setState(() {
                                      _reset();
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavBar()));
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]))),
        ));
  }


  void _reset() {
    setState(() {
      _descriptionController.text = "";
      _weightController.text = "";
      _priceController.text = "";
      _charityPCController.text = "";
      _closingDateController.text = DateFormat('dd/MM/yy').format(_currentDate);
      _closingTimeController.text = _closingTime.toString();
      _collectionDateController.text =
          DateFormat('dd/MM/yy').format(_currentDate);
      _collectionTimeController.text = _collectionTime.toString();
      listStringItems.clear();
    });
  }

  Future<BoxClass> _prepareBox() async {
    DateTime now = DateTime.now();
    Timestamp nowTS = Timestamp.fromDate(now);
    String thisYear = now.year.toString();
    String thisYearShort = thisYear.substring(2, 4);
    String thisMonth = now.month.toString().padLeft(2, '0');
    String thisDay = now.day.toString().padLeft(2, '0');
    String thisHour = now.hour.toString().padLeft(2, '0');
    String thisMinute = now.minute.toString().padLeft(2, '0');
    String thisSecond = now.second.toString().padLeft(2, '0');
    String closeYearFromController = _closingDateController.text;
    String closeYear =
        "20${closeYearFromController.substring(6, 8).toString()}";
    String closeMonth = _closingDateController.text.substring(3, 5).toString();
    String closeDay = _closingDateController.text.substring(0, 2).toString();
    String closeHour = _closingTimeController.text.substring(0, 2).toString();
    String closeMinute = _closingTimeController.text.substring(3, 5).toString();
    String closeSecond = "00";
    String closeDateTimeString =
        "$closeYear-$closeMonth-$closeDay $closeHour:$closeMinute:$closeSecond";
    DateTime closeDateTime = DateTime.parse(closeDateTimeString);

    Timestamp closeTS = Timestamp.fromDate(closeDateTime);
    String _boxID =
        "$storeID$thisYearShort$thisMonth$thisDay$thisHour$thisMinute$thisSecond";
    String filename = "$_boxID\.jpg";
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_storedImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    imageURL = Uri.parse(await firebaseStorageRef.getDownloadURL() as String)
        .toString();
    return BoxClass(
        _boxID,
        storeID,
        _currentBoxTypeSelected,
        nowTS,
        closeTS,
        double.parse(_priceController.text),
        _descriptionController.text,
        double.parse(_weightController.text),
        _currentCharityNameSelected,
        double.parse(_charityPCController.text),
        imageURL.toString());
  }

  ItemClass _prepareItem({String boxID, String itemName, int index}) {
    index = index + 1;
    String _itemID = "$boxID${index.toString().padLeft(2, "0")}";
    return ItemClass(_itemID, "$boxID", "$itemName");
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
    final TimeOfDay closingTime = TimeOfDay(
        hour: int.parse(_closingTime.split(":")[0]),
        minute: int.parse(_closingTime.split(":")[1]));
    final TimeOfDay timePicked = await showTimePicker(
      context: context,
      initialTime: closingTime,
    );
    if (timePicked != null && timePicked != closingTime)
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

  void _inputItemsDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20.0,
                            offset: const Offset(0.0, 20.0),
                          ),
                        ]),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 8.0),
                        Text(
                          "ADD AN ITEM",
                          style: Theme.of(context).textTheme.title,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24.0),
                        TextField(
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
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
                              onPressed: _clearEntry),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Text("Add item"),
                              onPressed: () {
                                _addItemToList();
                              }),
                        ),
                        RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Text("Finish"),
                            onPressed: () {
                              _addItemToList();
                              Navigator.of(context).pop();
                            }),
                        SizedBox(height: 24.0),
                        Text(
                          "Type a description of the item into the input space.\n\n"
                              "Click FINISH if you have no more products to add.\n\n"
                              "Click ADD ITEM if you have more items to add.\n\n"
                              "Click CLEAR at any time to clear the input space",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _getPicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = imageFile;
    });
  }

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = imageFile;
    });
  }

  void _clearEntry() {
    setState(() {
      _itemController.text = "";
    });
  }

  void _addItemToList() {
    setState(() {
      if (_itemController.text.length > 0) {
        listStringItems.add(_itemController.text);
        _clearEntry();
      }
    });
  }

//This isn't working yet - time beat me!
  CharityClass _getCharityObject(DocumentSnapshot charitySnap) {
    String _charityName = charitySnap["charityName"];
    String _charityDescription = charitySnap["charityDescription"];
    String _charityAddress1 = charitySnap["charityAddress1"];
    String _charityAddress2 = charitySnap["charityAddress2"];
    String _charityTown = charitySnap["charityTown"];
    String _charityCounty = charitySnap["charityCounty"];
    String _charityPostcode = charitySnap["charityPostcode"];
    String _charityContactName = charitySnap["charityContactName"];
    String _charityTelephone = charitySnap["charityTelephone"];
    String _charityMail = charitySnap["charityMail"];
    return CharityClass(
        _charityName,
        _charityDescription,
        _charityAddress1,
        _charityAddress2,
        _charityTown,
        _charityCounty,
        _charityPostcode,
        _charityContactName,
        _charityTelephone,
        _charityMail,
        _charityDescription);
  }
}

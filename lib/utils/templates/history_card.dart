import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildHistoryCard(BuildContext context, DocumentSnapshot document) {
  DateTime closeDateFromFirestore = DateTime.fromMillisecondsSinceEpoch(
      document["endDateTime"].millisecondsSinceEpoch);
  String closeDateFormat =
  DateFormat("dd/MM/yy").format(closeDateFromFirestore);
  String closeTimeFormat = DateFormat("HH:mm").format(closeDateFromFirestore);

  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    color: _getCardColor(
        context: context,
        now: DateTime.now(),
        closeDate: closeDateFromFirestore),
    elevation: 8.0,
    borderOnForeground: true,
    child: Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Image of box contents

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                "${document["imageURL"]}",
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),

          //Contents of column

          Expanded(
            child: Column(
              children: <Widget>[
                //mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.start,

                Text(
                  document["boxID"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(
                  document["boxType"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //Contents of column

                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "End Date:",
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "End Time:",
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              closeDateFormat,
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              closeTimeFormat,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "RRP:",
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Bids:",
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "£${document["RRP"].toString()}",
                            textAlign: TextAlign.right,
                          ),
                          Text("0"
                              //box.numberOfBids.toString(),
                              //textAlign: TextAlign.right,
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Winner's Name"

//                      box.winnerName,
//                      style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                    Spacer(),
                    Text("00.00"
//                      "£${box.highBid.toStringAsFixed(2)}",
//                      style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Color _getCardColor({BuildContext context, DateTime now, DateTime closeDate}) {
  if (now.isBefore(closeDate)) {
    return Theme
        .of(context)
        .hintColor;
  } else {
    return Theme
        .of(context)
        .scaffoldBackgroundColor;
  }
}

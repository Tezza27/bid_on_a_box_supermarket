import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/colours.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget buildHistoryCard(BuildContext context, DocumentSnapshot document) {
  //final AsyncSnapshot<dynamic> snapshot = ; //boxList[index];
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
            child: Container(
              decoration: BoxDecoration(
                color: accent_01Color,
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 100,
              width: 100,

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
                              document["endDate"],
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              document["endTime"],
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

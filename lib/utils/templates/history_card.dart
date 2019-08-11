import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/colours.dart';

Widget buildHistoryCard(BuildContext context, int index) {
  final box = null; //boxList[index];
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 4.0,
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
              height: 100,
              width: 100,
              color: accent_01Color,
            ),
          ),

          //Contents of column

          Expanded(
            child: Column(
              children: <Widget>[

                  Row(
                    //mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        box.boxType,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        box.boxID,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                              box.endDate,
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              box.endTime,
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
                            "£${box.rRP.toStringAsFixed(2)}",
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            box.numberOfBids.toString(),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      box.winnerName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "£${box.highBid.toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
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

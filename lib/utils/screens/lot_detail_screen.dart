import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bid_on_a_box_supermarket/utils/services/item_detail_data.dart';
import 'package:bid_on_a_box_supermarket/utils/services/item_bid_data.dart';

class LotDetailScreen extends StatelessWidget {
  final document;

  LotDetailScreen(this.document);

  @override
  Widget build(BuildContext context) {
    DateTime startDateFromFirestore = DateTime.fromMillisecondsSinceEpoch(
        document["startDateTime"].millisecondsSinceEpoch);
    String startDateFormat =
        DateFormat("dd/MM/yy").format(startDateFromFirestore);
    String startTimeFormat =
        DateFormat("HH:mm:ss").format(startDateFromFirestore);
    DateTime closeDateFromFirestore = DateTime.fromMillisecondsSinceEpoch(
        document["endDateTime"].millisecondsSinceEpoch);
    String closeDateFormat =
        DateFormat("dd/MM/yy").format(closeDateFromFirestore);
    String closeTimeFormat =
        DateFormat("HH:mm:ss").format(closeDateFromFirestore);
    Duration duration =
        closeDateFromFirestore.difference(startDateFromFirestore);
    int durHours = duration.inHours;
    int durMinutes = duration.inMinutes - (durHours * 60);
    int durSeconds = duration.inSeconds - (durMinutes * 60);
    String itemBoxID = document["boxID"];

    return Scaffold(
        appBar: AppBar(title: Text(itemBoxID)),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 32, right: 32),
              child: Column(children: <Widget>[
                Container(
                  //Image holder with camera icon
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    document["boxType"],
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    document["boxDescription"],
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "OPENED:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "$startDateFormat $startTimeFormat",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "DURATION:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "$durHours:$durMinutes:$durSeconds",
                                textAlign: TextAlign.center,
                              ),
                              Row(children: <Widget>[
                                Flexible(
                                  flex: 50,
                                  child: Container(
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).hintColor)),
                                ),
                                Flexible(
                                  flex: 50,
                                  child: Container(
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "CLOSED:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "$closeDateFormat $closeTimeFormat",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "KG",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${document["boxWeight"].toString()}",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: <Widget>[
                          Text(
                            "CHARITY:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            document["boxCharity"],
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: <Widget>[
                          Text(
                            "%",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${document["boxCharityPercent"].toString()}",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: <Widget>[
                          Text(
                            "£RRP",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${document["RRP"].toString()}",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "ITEMS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                buildItemBody(context, itemBoxID),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "BID HISTORY",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(flex: 1, child: Text("Date", textAlign: TextAlign.left,)),
                        Flexible(flex: 1, child: Text("Time", textAlign: TextAlign.left,)),
                        Flexible(flex: 1, child: Text("£Bid", textAlign: TextAlign.left,)),
                        Flexible(flex: 1, child: Text("RRP%", textAlign: TextAlign.left,)),
                      ],
                    ),
                    buildBidBody(context, itemBoxID, document["RRP"])
                  ],
                ),
              ])),
        ));
  }

//  String _auctionStatus() {
//    return "Difference";
//  }

}

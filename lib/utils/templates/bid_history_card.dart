import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/colours.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


Widget buildBidCard(BuildContext context, DocumentSnapshot document, double bidRRP) {
  DateTime bidDateFromFirestore = DateTime.fromMillisecondsSinceEpoch(document["endDateTime"].millisecondsSinceEpoch);
  String bidDateFormat =DateFormat("dd/MM/yy").format(bidDateFromFirestore);
  String bidTimeFormat =DateFormat("HH:mm").format(bidDateFromFirestore);
  String _bidPercent = (document["bidAmount"]/bidRRP).toString();

  Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)),
    elevation: 4.0,
    borderOnForeground: true,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text(bidDateFormat, textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.body1),
          ),
          Flexible(
            flex: 1,
            child: Text(bidTimeFormat, textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.body1),
          ),
          Flexible(
            flex: 1,
            child: Text("${document["bidAmount"].toString()}", textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.body1),
          ),
          Flexible(
            flex: 1,
            child: Text(_bidPercent, textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.body1),
          ),
        ],
      ),
    ),
  );
}
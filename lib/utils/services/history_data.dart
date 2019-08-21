import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/templates/history_card.dart';
import 'package:bid_on_a_box_supermarket/utils/variables/variables.dart';
import 'package:bid_on_a_box_supermarket/utils/screens/lot_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget buildHistoryBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('boxes').where("storeID", isEqualTo: storeID).orderBy("endDateTime", descending: true).orderBy("startDateTime", descending: true).snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) return Center(
        child: Column(
          children: <Widget>[
            Text("Loading data..."),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: LinearProgressIndicator(),
            ),
          ],
        ),
      );

      return _buildHistoryList(context, snapshot.data.documents);
    },
  );
}

Widget _buildHistoryList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.length,
      //boxList.length,
      itemBuilder: (context, int index) {
        return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LotDetailScreen(snapshot[index])));
            },
            child: buildHistoryCard(context, snapshot[index]));
      });
}
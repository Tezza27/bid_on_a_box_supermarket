import 'package:bid_on_a_box_supermarket/utils/templates/bid_history_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget buildBidBody(BuildContext context, String itemBoxID, double boxRRP) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance
        .collection('bids')
        .where("boxID", isEqualTo: itemBoxID)
        .orderBy("bidDateTime", descending: true)
        .snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData)
        return Center(
          child: Container(
              child: Text("No bids received", textAlign: TextAlign.center,)),
        );

      return _buildBidList(context, snapshot.data.documents, boxRRP);
    },
  );
}

Widget _buildBidList(BuildContext context, List<DocumentSnapshot> snapshot,
    double bidRRP) {
  return ListView.builder(
      itemCount: snapshot.length,
      //boxList.length,
      itemBuilder: (context, int index) {
        return buildBidCard(context, snapshot[index], bidRRP);
      });
}

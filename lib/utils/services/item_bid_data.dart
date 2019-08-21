import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/templates/bid_history_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget buildBidBody(BuildContext context, String itemBoxID, double boxRRP) {
  String varBoxID = itemBoxID;
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('bids').where(
        "boxID", isEqualTo: itemBoxID)
        .orderBy("bidDateTime", descending: true)
        .snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) return Text("No bids received");

      return _buildBidList(context, snapshot.data.documents, boxRRP);
    },
  );
}

Widget _buildBidList(BuildContext context, List<DocumentSnapshot> snapshot, double bidRRP) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.length,
      //boxList.length,
      itemBuilder: (context, int index) {
        return buildBidCard(context, snapshot[index], bidRRP);
      } );
}
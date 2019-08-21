import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Widget buildItemBody(BuildContext context, String itemBoxID) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('items').where("boxID", isEqualTo: itemBoxID).snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();

      return _buildItemList(context, snapshot.data.documents);
    },
  );
}

Widget _buildItemList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(snapshot[index]["itemName"],
          textAlign: TextAlign.center,);
      });
}

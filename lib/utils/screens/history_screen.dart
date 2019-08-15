import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/templates/history_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


class HistoryScreen extends StatefulWidget{

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Bid-on-a-Box History")),

      body: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Container(
          child: StreamBuilder(
              stream: Firestore.instance.collection('boxes').snapshots(),
              builder: (context, snapshot){
           if (!snapshot.hasData){
              return Center(
                child: Text("Loading Data..."),
              );
            } else{
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length, //boxList.length,
                  itemBuilder: (context, int index) =>
                      buildHistoryCard(context, snapshot.data.documents[index]),
              );

            }
          })


        ),
      )

    );
  }

}
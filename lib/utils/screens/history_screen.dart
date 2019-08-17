import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/templates/history_card.dart';
import 'package:bid_on_a_box_supermarket/utils/models/box_class.dart';
import 'package:bid_on_a_box_supermarket/utils/screens/lot_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    List<BoxClass> _boxList = [];

    final box = BoxClass(
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null);
    return Scaffold(
      appBar: AppBar(title: Text("Bid-on-a-Box History")),
      body: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Container(
          child: StreamBuilder(
              stream: Firestore.instance.collection('boxes').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("Loading Data..."),
                  );
                } else {
                  //_boxList.add(snapshot.data);
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      //boxList.length,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LotDetailScreen(
                                            box: _boxList[index])));
                          },
                          child: buildHistoryCard(
                              context, snapshot.data.documents[index]),
                        );
                      });
                }
              }

          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import './utils/history_card.dart';
import './utils/box_list.dart';


class HistoryScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Bid-on-a-Box History")),

      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: boxList.length,
            itemBuilder: (BuildContext context, int index) =>
                buildHistoryCard(context, index)),

      )

    );
  }

}
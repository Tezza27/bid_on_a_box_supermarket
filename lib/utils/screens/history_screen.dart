import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/models/history_card.dart';
import 'package:bid_on_a_box_supermarket/utils/test_data/box_list.dart';


class HistoryScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Bid-on-a-Box History")),

      body: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: boxList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildHistoryCard(context, index)),

        ),
      )

    );
  }

}
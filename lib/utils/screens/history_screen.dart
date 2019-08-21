import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/services/history_data.dart';
class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lot History")),
      body: buildHistoryBody(context),
    );

  }


}

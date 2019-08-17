import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/models/box_class.dart';
import 'package:bid_on_a_box_supermarket/utils/screens/history_screen.dart';

class LotDetailScreen extends StatelessWidget {
  final BoxClass box;
  LotDetailScreen({Key key, @required this.box}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Bid-on-a-Box Lot Detail")),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(children: <Widget>[
                Container(
                  //Image holder with camera icon
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Container(
                      child: Icon(Icons.camera_enhance, size: 30),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(box.boxID),
                    Text("DURATION"),
                    Text("END"),
                  ],
                ),
              ])),
        ));
  }
}

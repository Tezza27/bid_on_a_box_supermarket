import 'package:flutter/material.dart';


class HistoryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Bid-on-a-Box History")),

      body: Container(
        child: Center(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Account History Page will provide a list view, containing some high level details, of all lots that have been listed",
          style: Theme.of(context).primaryTextTheme.headline,
          ),
        ))

      )

    );
  }

}
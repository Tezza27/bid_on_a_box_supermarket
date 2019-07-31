import 'package:flutter/material.dart';


class AnalysisScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("Bid-on-a-Box Analysis")),
        body: Container(
            child: Center(child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Analysis screen will provide totals for specified periods of time",
                style: Theme.of(context).primaryTextTheme.headline,
              ),
            ))

        )

    );
  }

}
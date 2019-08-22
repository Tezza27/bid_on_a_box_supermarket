import 'package:flutter/material.dart';

//I was over-ambitious.  I had intended to have a nice dashboard, providing the user with the ability to
//stipulate 2 periods of their choice (using date pickers) to analyse and compare performance metrics
//between the 2 periods (e.g. this week vs last week.
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
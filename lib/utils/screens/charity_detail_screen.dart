import 'package:flutter/material.dart';

class CharityDetailScreen extends StatelessWidget {
//  final document;

//  CharityDetailScreen(this.document);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Charity Name")),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 32, right: 32),
              child: Column(children: <Widget>[
                Text("Charity Description"),
                Text("CONTACT:"),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Address 1"),
                        Text("Address 2"),
                        Text("Town"),
                        Text("County"),
                        Text("Postcode"),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("Contact"),
                        Text("Name"),
                        Text("Telephone"),
                        Text("email"),
                      ],
                    )
                  ],
                ),
                Text("Charity Description"),
                Text("Charity Description"),
                Text("Charity Description"),
                Text("Charity Description"),
                Text("Charity Description"),
                Text("Charity Description"),
                Text("Charity Description"),
                Text("Charity Description"),
              ])),
        ));
  }

//  String _auctionStatus() {
//    return "Difference";
//  }

}

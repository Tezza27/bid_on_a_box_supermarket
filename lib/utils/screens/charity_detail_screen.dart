import 'package:flutter/material.dart';

class CharityDetailScreen extends StatelessWidget {
  final selectedCharityObject;

  CharityDetailScreen(this.selectedCharityObject);



  @override
  Widget build(BuildContext context) {
    String _charityName = selectedCharityObject["charityName"];
    String _charityDescription = selectedCharityObject["charityDescription"];
    String _charityAddress1 = selectedCharityObject["charityAddress1"];
    String _charityAddress2 = selectedCharityObject["charityAddress2"];
    String _charityTown = selectedCharityObject["charityTown"];
    String _charityCounty = selectedCharityObject["charityCounty"];
    String _charityPostcode = selectedCharityObject["charityPostcode"];
    String _charityContactName = selectedCharityObject["charityContactName"];
    String _charityTelephone = selectedCharityObject["charityTelephone"];
    String _charityMail = selectedCharityObject["charityMail"];
    return Scaffold(
        appBar: AppBar(title: Text(_charityName)),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 32, right: 32),
              child: Column(children: <Widget>[
                Text("CONTACT:"),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(_charityAddress1),
                        Text(_charityAddress2),
                        Text(_charityTown),
                        Text(_charityCounty),
                        Text(_charityPostcode),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("Contact:"),
                        Text(_charityContactName),
                        Text(_charityTelephone),
                        Text(_charityMail),
                      ],
                    )
                  ],
                ),
                Text(_charityDescription),
              ])),
        ));
  }
}

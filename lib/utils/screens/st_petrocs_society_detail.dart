import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StPetrocsSocietyScreen extends StatelessWidget {
//This is a last minute shortcut as I was unable to get the functionality in place in time
//It was my intention to have the information uploading from Firestore, but I was beaten by time!

  @override
  Widget build(BuildContext context) {
    String _charityName = "St Petroc's Society";
    String _charityDescription =
        "We believe homelessness shouldn’t be an issue in our society today We’re working to end street homelessness in Cornwall by providing accommodation, support, advice, training and resettlement services to single homeless people.";
    String _charityAddress1 = "Lander House";
    String _charityAddress2 = "5 Upper Lemon Villas";
    String _charityTown = "Truro";
    String _charityCounty = "Cornwall";
    String _charityPostcode = "TR1 2PD";
    String _charityContactName = "Steve Ellis";
    String _charityTelephone = "01872 260948";
    String _charityMail = "home@stpetrocs.org.uk";
    return Scaffold(
        appBar: AppBar(title: Text(_charityName)),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
              child: Container(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 8.0,
                      borderOnForeground: true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(_charityAddress1,
                                    style: Theme.of(context).textTheme.body1),
                                Text(_charityAddress2,
                                    style: Theme.of(context).textTheme.body1),
                                Text(_charityTown,
                                    style: Theme.of(context).textTheme.body1),
                                Text(_charityCounty,
                                    style: Theme.of(context).textTheme.body1),
                                Text(_charityPostcode,
                                    style: Theme.of(context).textTheme.body1),
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text("Contact:",
                                    style: Theme.of(context).textTheme.body1),
                                Text(_charityContactName,
                                    style: Theme.of(context).textTheme.body1),
                                Text(_charityTelephone,
                                    style: Theme.of(context).textTheme.body1),
                                Text(_charityMail,
                                    style: Theme.of(context).textTheme.body1),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Container(
                      height: 4.0,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 4.0,
                          borderOnForeground: true,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                                child: Text(
                              _charityDescription,
                              style: Theme.of(context).textTheme.headline,
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ]),
              )),
        ));
  }
}

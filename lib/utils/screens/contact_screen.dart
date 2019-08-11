import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactState();
  }
}

class _ContactState extends State<ContactScreen> {
  TextEditingController _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Tell Us What you Think")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 32.0, left: 32.0, right: 32.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "The Bid-on-a-Box team are constantly on the lookout for ways to improve the app and "
                      "the experience for users.  We'd love for you to be a part of this process, and so we "
                      "welcome all your messages."),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Please tell us what you like about using the app, and, more importantly, what"
                        " you don't like."),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "If you have any ideas that you think could improve the app, or how you use it, we'd"
                        " really like to know about them."),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "We can't promise to incorporate all of the ideas that we receive, but we can promise "
                        "that each one will be given full consideration during the next stage of development, "
                        "and we will be very grateful for your input."),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("We look forward to hearing from you soon.")),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("The Bid-on-a-Box Team")),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    //textInputAction: TextInputAction.done,
                    controller: _contactController,
                    maxLength: 2000,
                    maxLines: null,
                    decoration: InputDecoration(
                        labelText: "Tell Us What you Think",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: RaisedButton(
                              //Clears the contact text field
                              child: Text("Cancel"),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                              onPressed: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => HistoryScreen()));
                              }),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RaisedButton(
                              //Sends the message
                              child: Text("Send"),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                              onPressed: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => HistoryScreen())
//                  )
                              }),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

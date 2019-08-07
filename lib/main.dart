import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/screens/history_screen.dart';
import 'package:bid_on_a_box_supermarket/utils/screens/new_lot_screen.dart';
import 'package:bid_on_a_box_supermarket/utils/screens/analysis_screen.dart';
import './utils/colours.dart';
import 'package:bid_on_a_box_supermarket/utils/screens/contact_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
  theme: ThemeData(
      brightness: Brightness.light,

      primaryColor: brand_01Color,
      accentColor: accent_01Color,
      buttonColor: brand_01Color,
      bottomAppBarColor: brand_01Color,
//          primaryColorLight: ,
//          primaryColorDark: ,
//          canvasColor: ,
      scaffoldBackgroundColor: whiteColor,
          cardColor: whiteColor,
//          dividerColor: ,
//          focusColor: ,
//          hoverColor: ,
//          highlightColor: ,
//          splashColor: ,
//          selectedRowColor: ,
//          unselectedWidgetColor: ,
//          disabledColor: ,
//          secondaryHeaderColor: ,
//          textSelectionColor: ,
//          cursorColor: ,
//          textSelectionHandleColor: ,
//          backgroundColor: ,
//          dialogBackgroundColor: ,
//          indicatorColor: ,
          hintColor: accent_03Color,
//          errorColor: ,
//          toggleableActiveColor: ,


// To map the fonts from the team visual style guide
// in order to ensure consistency across development
// The font weights have been translated as follows:
// Heavy = W900
// Bold =  W700
// Medium = W500
// Regular = W400
// Light = W300

      primaryTextTheme: TextTheme(
        title: TextStyle(
            color: copy_01Color,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 24),
        //AppBar Text
        headline:TextStyle(
            color: copy_01Color,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 24),
        //Team names
        subtitle: TextStyle(
            color: copy_01Color,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w300,
            fontSize: 18),

        subhead: TextStyle(
            color: copy_01Color,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 16),

        body1: TextStyle(
            color: copy_01Color,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 16),

        body2: TextStyle(
            color: copy_01Color,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w300,
            fontSize: 14),

        display1: TextStyle(
            color: copy_01Color,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 12),

        display2: TextStyle(
            color: copy_01Color,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 12),

        button: TextStyle(
            color: copy_01Color,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w300,
            fontSize: 10), //Button Text

      )),


  home: BottomNavBar()
));
}


class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  final _pageOption = [HistoryScreen(), NewLotScreen(), AnalysisScreen(), ContactScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: Theme.of(context).bottomAppBarColor,
        initialIndex: 0,
        items: <Widget>[
          Icon(Icons.history, size: 30),
          Icon(Icons.add_circle, size: 30),
          Icon(Icons.assessment, size: 30),
          Icon(Icons.mail, size: 30)
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _pageOption[_page],
    );
  }
}

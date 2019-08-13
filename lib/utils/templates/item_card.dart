import 'package:flutter/material.dart';
import 'package:bid_on_a_box_supermarket/utils/colours.dart';

Widget itemCard(BuildContext context, int index) {
  final item = null;
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 4.0,
    borderOnForeground: true,

    child: Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Text(item.description),
    ),
  );
}
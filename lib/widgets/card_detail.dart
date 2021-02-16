import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardDetail extends StatelessWidget {
  final String title;
  final DateTime dateTime;

  CardDetail({
    @required this.title,
    @required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          DateFormat.yMMMMEEEEd().format(dateTime),
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}

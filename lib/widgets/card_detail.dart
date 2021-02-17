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
        Container(
          padding: EdgeInsets.only(
            right: 10,
          ),
          child: FittedBox(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            right: 10,
          ),
          child: FittedBox(
            child: Text(
              DateFormat.yMMMMEEEEd().format(dateTime),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}

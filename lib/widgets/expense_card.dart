import 'dart:io';

import 'package:expense_planner/widgets/card_detail.dart';
import 'package:expense_planner/widgets/price_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final String id;
  final double amount;
  final String title;
  final DateTime dateTime;
  final Function onDeleteFunc;

  ExpenseCard({
    @required this.id,
    @required this.amount,
    @required this.title,
    @required this.dateTime,
    @required this.onDeleteFunc,
  });

  @override
  Widget build(BuildContext context) {
    var cupertinoDeleteBtn = CupertinoButton(
      onPressed: () => onDeleteFunc(id),
      child: Icon(
        CupertinoIcons.delete,
        size: 30,
        color: Theme.of(context).errorColor,
      ),
    );
    var landscapeIcon = Platform.isIOS
        ? cupertinoDeleteBtn
        : FlatButton.icon(
            icon: Icon(Icons.delete),
            textColor: Theme.of(context).errorColor,
            label: Text('Delete'),
            onPressed: () => onDeleteFunc(id),
          );
    var portraitIcon = Platform.isIOS
        ? cupertinoDeleteBtn
        : IconButton(
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            iconSize: 30,
            onPressed: () => onDeleteFunc(id),
          );
    return Card(
      child: Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            PriceDetail(amount: amount),
            Flexible(
              fit: FlexFit.tight,
              child: CardDetail(
                title: title,
                dateTime: dateTime,
              ),
            ),
            MediaQuery.of(context).size.width > 460
                ? landscapeIcon
                : portraitIcon,
          ],
        ),
      ),
      elevation: 5,
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
      ),
    );
  }
}

import 'package:expense_planner/widgets/card_detail.dart';
import 'package:expense_planner/widgets/price_detail.dart';
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
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              iconSize: 30,
              onPressed: () => onDeleteFunc(id),
            ),
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

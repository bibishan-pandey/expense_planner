import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({@required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, idx) {
          return ExpenseCard(
            amount: transactions[idx].amount,
            title: transactions[idx].title,
            dateTime: transactions[idx].dateTime,
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}

// ListView() {
//   children: <Widget>[
//     ...transactions.map((transaction) {
//       return ExpenseCard(
//         amount: transaction.amount,
//         title: transaction.title,
//         dateTime: transaction.dateTime,
//       );
//     }).toList(),
//     Container(
//       margin: EdgeInsets.all(16),
//       child: Text(
//         'You\'ve reached the end of the transaction!',
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w300,
//           color: Colors.grey,
//         ),
//       ),
//     ),
//   ],
// },

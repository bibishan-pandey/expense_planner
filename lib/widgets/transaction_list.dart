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
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
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

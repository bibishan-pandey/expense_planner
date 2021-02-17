import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function onDeleteFunc;

  TransactionList({@required this.transactions, @required this.onDeleteFunc});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        child: transactions.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                    width: constraints.maxWidth,
                  ),
                  Flexible(
                    child: Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                    width: constraints.maxWidth,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.55,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                ),
                itemBuilder: (ctx, idx) {
                  return ExpenseCard(
                    id: transactions[idx].id,
                    amount: transactions[idx].amount,
                    title: transactions[idx].title,
                    dateTime: transactions[idx].dateTime,
                    onDeleteFunc: onDeleteFunc,
                  );
                },
                itemCount: transactions.length,
              ),
      );
    });
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

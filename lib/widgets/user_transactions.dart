import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/add_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '513c9f180b3934d08ef2a0e7fa5ae96f',
      title: 'Shoes',
      amount: 69.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 'ce5a1a3d70df73cf83042be491d5f895',
      title: 'Jacket',
      amount: 59.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: '81108597c07f13a51a83417f715a474c',
      title: 'Pant',
      amount: 44.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: '6807198c928eed879f3766d49954e92b',
      title: 'Google',
      amount: 29.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 'a4be1280e0b263f8acf6bed3a9303959',
      title: 'Shirt',
      amount: 19.99,
      dateTime: DateTime.now(),
    ),
  ];

  void _addTransaction(String title, double price) {
    var uuid = Uuid();

    final newTransaction = Transaction(
      id: uuid.v4().toString(),
      title: title,
      amount: price,
      dateTime: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddTransaction(
          onPressedFunc: _addTransaction,
        ),
        TransactionList(
          transactions: _transactions,
        ),
      ],
    );
  }
}

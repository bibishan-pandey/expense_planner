import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/add_transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final String _title = 'Expense Planner';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dividerTheme: DividerThemeData(
          space: 5,
          thickness: 1,
          color: Colors.blue,
        ),
      ),
      home: _HomePage(title: _title),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _HomePage extends StatefulWidget {
  final String title;

  _HomePage({
    this.title,
  });

  @override
  __HomePageState createState() => __HomePageState();
}

class __HomePageState extends State<_HomePage> {
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

  void _showAddTransactionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builderContext) {
        return GestureDetector(
          onTap: () {},
          child: AddTransaction(
            onPressedFunc: _addTransaction,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => _showAddTransactionModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(),
            TransactionList(
              transactions: _transactions,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTransactionModal(context),
      ),
    );
  }
}

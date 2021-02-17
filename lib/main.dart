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
        primarySwatch: Colors.red,
        // change dark and light theme
        // colorScheme: ColorScheme.light(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dividerTheme: DividerThemeData(
          space: 5,
          thickness: 1,
          color: Colors.blue,
        ),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
          actionsIconTheme: ThemeData.light().iconTheme.copyWith(
                color: Colors.white,
              ),
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
      dateTime: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 'ce5a1a3d70df73cf83042be491d5f895',
      title: 'Jacket',
      amount: 59.99,
      dateTime: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: '81108597c07f13a51a83417f715a474c',
      title: 'Pant',
      amount: 44.99,
      dateTime: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: '6807198c928eed879f3766d49954e92b',
      title: 'Google',
      amount: 29.99,
      dateTime: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 'a4be1280e0b263f8acf6bed3a9303959',
      title: 'Shirt',
      amount: 19.99,
      dateTime: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 'b4be1280e0b263f8acf6bed3a9303939',
      title: 'Groceries',
      amount: 39.99,
      dateTime: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: 'c4be1280e0b263f8acf6bed3a9303989',
      title: 'Charger',
      amount: 29.99,
      dateTime: DateTime.now().subtract(Duration(days: 7)),
    ),
  ];

  List<Transaction> get _weeklyTransactions {
    return _transactions.where((transaction) {
      return transaction.dateTime.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

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
      id: uuid.v4().toString().split('-').join(),
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
            icon: Icon(Icons.add),
            onPressed: () => _showAddTransactionModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(
              transactions: _weeklyTransactions,
            ),
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

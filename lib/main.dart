import 'dart:io';

import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/add_transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(App());
}

class App extends StatelessWidget {
  final String _title = 'Expense Planner';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
              button: TextStyle(
                color: Colors.white,
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
      isScrollControlled: true,
      elevation: 5,
      builder: (builderContext) {
        return GestureDetector(
          onTap: () {},
          child: SingleChildScrollView(
            child: AddTransaction(
              onPressedFunc: _addTransaction,
            ),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _addTransaction(String title, double price, DateTime dateTime) {
    var uuid = Uuid();

    final newTransaction = Transaction(
      id: uuid.v4().toString().split('-').join(),
      title: title,
      amount: price,
      dateTime: dateTime,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _removeTransaction(String id) {
    if (id == null) return;
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  bool _toggleSwitchChart = true;

  @override
  Widget build(BuildContext context) {
    _transactions.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    var _switch = Switch.adaptive(
      value: _toggleSwitchChart,
      onChanged: (value) {
        setState(() {
          _toggleSwitchChart = value;
        });
      },
      activeColor: Theme.of(context).accentColor,
    );

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(widget.title),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                _switch,
                GestureDetector(
                  onTap: () => _showAddTransactionModal(context),
                  child: Icon(
                    CupertinoIcons.add,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(widget.title),
            actions: <Widget>[
              _switch,
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _showAddTransactionModal(context),
              ),
            ],
          );

    var body = SafeArea(
      child: Column(
        children: <Widget>[
          Visibility(
            visible: _toggleSwitchChart,
            child: Flexible(
              flex: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 1
                  : 3,
              fit: FlexFit.tight,
              child: Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    1,
                child: Chart(
                  transactions: _weeklyTransactions,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransactionList(
                transactions: _transactions.reversed.toList(),
                onDeleteFunc: _removeTransaction,
              ),
            ),
          ),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: body,
          )
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showAddTransactionModal(context),
                  ),
          );
  }
}

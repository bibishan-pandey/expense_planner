import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/user_transactions.dart';
import 'package:flutter/material.dart';

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

class _HomePage extends StatelessWidget {
  final String title;

  _HomePage({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(),
            UserTransactions(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

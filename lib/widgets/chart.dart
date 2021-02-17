import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:expense_planner/widgets/chart_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart({@required this.transactions});

  List<Map<String, Object>> get _groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].dateTime.day == weekDay.day &&
            transactions[i].dateTime.month == weekDay.month &&
            transactions[i].dateTime.year == weekDay.year) {
          totalAmount += transactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get _totalWeeklySpending {
    return _groupedTransactionValue.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ..._groupedTransactionValue.map((transaction) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      day: transaction['day'],
                      amount: transaction['amount'],
                      amountPercentage: _totalWeeklySpending == 0.0
                          ? 0.0
                          : (transaction['amount'] as double) /
                              _totalWeeklySpending,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ChartInfo(
            amount: _totalWeeklySpending,
          ),
        ],
      ),
      elevation: 5,
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
        bottom: 10,
      ),
    );
  }
}

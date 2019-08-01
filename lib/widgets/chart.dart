import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  //generates a series of transactionsbased on certain parametes (days of the week)
  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      //remember to intialize your damn variables because EVERYTHING is null in dart
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print('Week day: ${DateFormat.E().format(weekDay)}');
      print('Total sum: ${totalSum}');
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending =>
      groupedTransactionsValues.fold(0.0, (sum, item) => sum + item['amount']);

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues
          //flexible allows you to distribute the space inside a row or column between children
              .map((data) => Flexible( 
                    fit: FlexFit.tight,
                    child: ChartBar(
                      data['day'],
                      data['amount'],
                      totalSpending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalSpending,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

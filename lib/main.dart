import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    //TODO: Remove test transactions
    // **************************** TEST TRANSACTIONS ****************************
    //  Transaction(
    //      id: '0', title: "New shoes", amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: '1', title: "Groceries", amount: 10.99, date: DateTime.now()),
    // Transaction(
    //     id: '2', title: "New shoes", amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: '3', title: "More bananas", amount: 69.99, date: DateTime.now()),
    // Transaction(id: '4', title: "Test 2", amount: 69.99, date: DateTime.now()),
    // Transaction(id: '5', title: "Test 3", amount: 69.99, date: DateTime.now()),
    // Transaction(id: '6', title: "Test 4", amount: 69.99, date: DateTime.now()),
    // Transaction(id: '7', title: "Test 5", amount: 69.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    //only returns transactions that are younger than 7 days
    //********************************************************* */
    //where returns an iterable NOT a list with the items which satisfy the test condition
    //********************************************************* */
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount) {
    //creates a new transaction based on the passsed parameters
    final tx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() => _userTransactions.add(tx));
  }

  void _displayNewTransactionInput(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses Tracker'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _displayNewTransactionInput(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              //width: double.infinity,
                child: Chart(
                  _recentTransactions,
                ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _displayNewTransactionInput(context),
      ),
    );
  }
}

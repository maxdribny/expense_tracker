import 'package:expense_tracker/widgets/transaction_list.dart';

import './widgets/new_transaction.dart';

import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';

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
      ),
    );
  }
}

class MyHomePage extends StatefulWidget  {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: '0', title: "New shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: '1', title: "Groceries", amount: 10.99, date: DateTime.now()),
    Transaction(
        id: '2', title: "New shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: '3', title: "Test 1", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: '4', title: "Test 2", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: '5', title: "Test 3", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: '6', title: "Test 4", amount: 69.99, date: DateTime.now()),
        Transaction(
        id: '7', title: "Test 5", amount: 69.99, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    //creates a new transaction based on the passsed parameters
    final tx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() => _userTransactions.add(tx));
  }

  void _displayNewTransactionInput(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewTransaction(_addNewTransaction);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
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
              width: double.infinity,
              child: Card(
                //Card assumes size of its child unless you have a parent with a defined width.
                color: Colors.lightBlue,
                child: Text('CHART PLACEHOLDER'),
                elevation: 5,
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

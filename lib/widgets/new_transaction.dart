import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionPointer;

  NewTransaction(this.addTransactionPointer);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();
  final amountController = new TextEditingController();

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTransactionPointer(enteredTitle, enteredAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //Container in order to add padding around elements.
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
                controller: titleController,
                cursorColor: Colors.purpleAccent,
                //need to trigger function because you are really using a function which then calls the submitData function () { _submitData();} not _submitData()
                onSubmitted: (_) => _submitData(),
                decoration: InputDecoration(labelText: 'Title: ')),
            TextField(
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                controller: amountController,
                cursorColor: Colors.purpleAccent,
                decoration: InputDecoration(labelText: 'Amount: ')),
            FlatButton(
              child: Text('Add Transaction'),
              onPressed: _submitData,
              textColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}

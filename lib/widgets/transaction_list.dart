import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      //renders waiting.png image if the transactions list is empty
      child: _transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transactions Added',
                  style: Theme.of(context).textTheme.title,
                ),
                //spacing between the image and the title
                SizedBox(
                  height: 10,
                ),
                //Wrapping the Image child in a container in order to allow for sizing paramters
                //as a column takes the maximum space it can get.
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) => Card(
                elevation: 10,
                child: Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      '\£${_transactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _transactions[index].title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          //DateFormat object provided by intl package. .format() returns a string.
                          DateFormat('d MMM, yyyy')
                              .format(_transactions[index].date),
                          //tx.date.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ]),
                ]),
              ),
              itemCount: _transactions
                  .length, //insures that the widgets do not continue to attempt to infinitely build. Otherwise throws RangeError(Index) Index not in range error.
            ),
    );
  }
}

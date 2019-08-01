import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
            //creates a scrollable ListView dynamically
            //use this instead of static as it will only re-draw what needs to go on to the screen
            //more efficient for larger lists
          : ListView.builder(
              itemBuilder: (ctx, index) => Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                //ListTile -> a single fixed-height row that typically contians some text as well as a leading or trailing icon
                //Look at docs for good explanation [https://api.flutter.dev/flutter/material/ListTile-class.html]
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text('\$${_transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(_transactions[index].title,
                      style: Theme.of(context).textTheme.title),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_transactions[index].date),
                  ),
                ),
              ),
              itemCount: _transactions //the number of items to be built
                  .length, //insures that the widgets do not continue to attempt to infinitely build. Otherwise throws RangeError(Index) Index not in range error.
            ),
    );
  }
}

import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  final Function onPressedFunc;

  AddTransaction({this.onPressedFunc});

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();

  final priceController = TextEditingController();

  void submit() {
    final inputTitle = titleController.text;
    final inputPrice = double.parse(priceController.text);

    if (inputTitle.isEmpty || inputPrice <= 0.0) {
      return;
    }

    widget.onPressedFunc(
      inputTitle,
      inputPrice,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Add a new transaction',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          TextField(
            onSubmitted: (_) => submit(),
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Expense Name',
              hintText: 'E.g. Shoes',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          TextField(
            onSubmitted: (_) => submit(),
            controller: priceController,
            decoration: InputDecoration(
              labelText: 'Price',
              hintText: 'E.g. 69.99',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            keyboardType: TextInputType.numberWithOptions(
              decimal: true,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            child: FlatButton(
              onPressed: submit,
              child: Text('Add Expense'),
              color: Colors.blue,
              textColor: Colors.white,
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function onPressedFunc;

  AddTransaction({this.onPressedFunc});

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime _inputDateTime;

  void _submit() {
    if (_priceController.text.isEmpty) return;

    final _inputTitle = _titleController.text;
    final _inputPrice = double.parse(_priceController.text);

    if (_inputTitle.isEmpty ||
        _inputPrice <= 0.0 ||
        _inputTitle.length > 35 ||
        _inputDateTime == null) {
      return;
    }

    widget.onPressedFunc(
      _inputTitle,
      _inputPrice,
      _inputDateTime,
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _inputDateTime = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Add a new transaction',
            style: Theme.of(context).textTheme.headline6,
          ),
          TextField(
            onSubmitted: (_) => _submit(),
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Expense Name',
              helperText: 'Expense name should be less than 35 characters',
              hintText: 'E.g. Shoes',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          TextField(
            onSubmitted: (_) => _submit(),
            controller: _priceController,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: Text(_inputDateTime == null
                    ? 'No date chosen'
                    : DateFormat.yMMMMEEEEd().format(_inputDateTime)),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: 20,
                ),
                child: FlatButton(
                  onPressed: _showDatePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            child: RaisedButton(
              onPressed: _submit,
              child: Text('Add Expense'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              elevation: 5,
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

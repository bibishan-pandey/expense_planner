import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    Platform.isIOS
        ? showCupertinoModalPopup(
            context: context,
            builder: (_) => Container(
                  height: 500,
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            maximumDate: DateTime.now(),
                            maximumYear: DateTime.now().year,
                            minimumDate: DateTime(2000),
                            onDateTimeChanged: (value) {
                              setState(() {
                                _inputDateTime = value;
                              });
                            }),
                      ),
                      CupertinoButton(
                        child: Text('OK'),
                        onPressed: () {
                          if (_inputDateTime == null) {
                            setState(() {
                              _inputDateTime = DateTime.now();
                            });
                          }
                          return Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ))
        : showDatePicker(
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
        top: 20 + MediaQuery.of(context).viewInsets.top,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Add a new transaction',
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Platform.isIOS
                ? CupertinoTextField(
                    controller: _titleController,
                    maxLength: 34,
                    onSubmitted: (_) => _submit(),
                    placeholder: 'Expense Name',
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 16,
                      right: 16,
                    ),
                  )
                : TextField(
                    onSubmitted: (_) => _submit(),
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Expense Name',
                      helperText:
                          'Expense name should be less than 35 characters',
                      hintText: 'E.g. Shoes',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Platform.isIOS
                ? CupertinoTextField(
                    controller: _priceController,
                    maxLength: 34,
                    onSubmitted: (_) => _submit(),
                    placeholder: 'Price',
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 16,
                      right: 16,
                    ),
                  )
                : TextField(
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
                child: Platform.isIOS
                    ? CupertinoButton(
                        onPressed: _showDatePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : FlatButton(
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
              bottom: 20,
            ),
            child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: _submit,
                    child: Text(
                      'Add Expense',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  )
                : RaisedButton(
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

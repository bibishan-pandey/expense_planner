import 'package:flutter/material.dart';

class AddTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final priceController = TextEditingController();

  final Function onPressedFunc;

  AddTransaction({this.onPressedFunc});

  void submit() {
    final inputTitle = titleController.text;
    final inputPrice = double.parse(priceController.text);

    if (inputTitle.isEmpty || inputPrice <= 0.0) {
      return;
    }

    onPressedFunc(
      inputTitle,
      inputPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (_) => submit(),
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Expense Name',
                hintText: 'E.g. Shoes',
              ),
            ),
            TextField(
              onSubmitted: (_) => submit(),
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                hintText: 'E.g. 69.99',
              ),
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            FlatButton(
              onPressed: submit,
              child: Text('Add Expense'),
              color: Colors.blue,
              textColor: Colors.white,
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
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

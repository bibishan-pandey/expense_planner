import 'package:flutter/material.dart';

class PriceDetail extends StatelessWidget {
  final double amount;

  const PriceDetail({
    Key key,
    @required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '\$',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: FittedBox(
              child: Text(
                '${amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(right: 10),
      width: 120,
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3),
          bottomLeft: Radius.circular(3),
        ),
        gradient: SweepGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColorDark,
          Theme.of(context).primaryColor,
        ], stops: [
          0.0,
          0.5,
          1.0
        ]),
      ),
    );
  }
}

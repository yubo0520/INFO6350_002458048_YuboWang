import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String expression;

  const CalculatorDisplay({Key? key, required this.expression}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.bottomRight,
      child: Text(
        expression,
        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
      ),
    );
  }
} 
import 'package:flutter/material.dart';

typedef ButtonPressedCallback = void Function(String);

class CalculatorKeypad extends StatelessWidget {
  final ButtonPressedCallback onButtonPressed;

  const CalculatorKeypad({Key? key, required this.onButtonPressed}) : super(key: key);

  // helper to create calculator buttons
  Widget _buildButton(String buttonText,
      {Color bgColor = Colors.white, Color textColor = Colors.black}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
          ),
          onPressed: () => onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildButton("7"),
            _buildButton("8"),
            _buildButton("9"),
            _buildButton("÷",
                bgColor: Colors.grey, textColor: Colors.white),
          ],
        ),
        Row(
          children: [
            _buildButton("4"),
            _buildButton("5"),
            _buildButton("6"),
            _buildButton("×",
                bgColor: Colors.grey, textColor: Colors.white),
          ],
        ),
        Row(
          children: [
            _buildButton("1"),
            _buildButton("2"),
            _buildButton("3"),
            _buildButton("-",
                bgColor: Colors.grey, textColor: Colors.white),
          ],
        ),
        Row(
          children: [
            _buildButton("C",
                bgColor: Colors.grey, textColor: Colors.white),
            _buildButton("0"),
            _buildButton("=",
                bgColor: Colors.orange, textColor: Colors.white),
            _buildButton("+",
                bgColor: Colors.grey, textColor: Colors.white),
          ],
        ),
      ],
    );
  }
} 
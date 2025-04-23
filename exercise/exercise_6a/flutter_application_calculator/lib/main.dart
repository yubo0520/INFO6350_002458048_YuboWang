import 'package:flutter/material.dart';
import 'widgets/calculator_display.dart';
import 'widgets/calculator_keypad.dart';

void main() {
  runApp(CalculatorApp());
}

// root widget that sets up the app
class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

// main calculator screen widget
class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = "0";
  bool _shouldReplaceExpression = false;
  bool _isNewCalculation = true;

  // handles all button press logic
  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // clear everything
        _expression = "0";
        _shouldReplaceExpression = false;
        _isNewCalculation = true;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        // handle operator input
        if (_shouldReplaceExpression) {
          // continue calculation with previous result
          _expression = _expression + buttonText;
          _shouldReplaceExpression = false;
        } else if (_isNewCalculation) {
          _expression = _expression + buttonText;
          _isNewCalculation = false;
        } else {
          // replace last operator if another is pressed without a number in between
          if (_expression.endsWith("+") || 
              _expression.endsWith("-") || 
              _expression.endsWith("×") || 
              _expression.endsWith("÷")) {
            _expression = _expression.substring(0, _expression.length - 1) + buttonText;
          } else {
            _expression = _expression + buttonText;
          }
        }
      } else if (buttonText == "=") {
        // calculate the result
        try {
          String expressionToEvaluate = _expression;
          expressionToEvaluate = expressionToEvaluate.replaceAll("×", "*");
          expressionToEvaluate = expressionToEvaluate.replaceAll("÷", "/");
          
          // evaluate the expression
          final result = _evaluateExpression(expressionToEvaluate);
          
          // display result
          _expression = result.toString().endsWith(".0") ? 
                        result.toString().split(".")[0] : 
                        result.toString();
          
          _shouldReplaceExpression = true;
        } catch (e) {
          _expression = "Error";
        }
      } else {
        // handle number input
        if (_expression == "0" || _isNewCalculation || _shouldReplaceExpression) {
          _expression = buttonText;
          _isNewCalculation = false;
          _shouldReplaceExpression = false;
        } else {
          _expression = _expression + buttonText;
        }
      }
    });
  }

  // evaluates a math expression
  double _evaluateExpression(String expression) {
    // simple expression evaluator
    List<String> parts = [];
    String currentNumber = "";
    String operator = "";
    
    // parse expression into numbers and operators
    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      if (char == "+" || char == "-" || char == "*" || char == "/") {
        if (currentNumber.isNotEmpty) {
          parts.add(currentNumber);
          currentNumber = "";
        }
        parts.add(char);
      } else {
        currentNumber += char;
      }
    }
    
    if (currentNumber.isNotEmpty) {
      parts.add(currentNumber);
    }
    
    // evaluate expression following order of operations
    double result = double.parse(parts[0]);
    for (int i = 1; i < parts.length; i += 2) {
      operator = parts[i];
      double num2 = double.parse(parts[i + 1]);
      
      if (operator == "+") {
        result += num2;
      } else if (operator == "-") {
        result -= num2;
      } else if (operator == "*") {
        result *= num2;
      } else if (operator == "/") {
        result /= num2;
      }
    }
    
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          // display area for calculation expression
          Expanded(
            child: CalculatorDisplay(expression: _expression),
          ),
          // keypad layout
          Expanded(
            flex: 2,
            child: CalculatorKeypad(onButtonPressed: _buttonPressed),
          ),
        ],
      ),
    );
  }
}
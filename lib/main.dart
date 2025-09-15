import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0"; // display output
  String _input = ""; // store user input

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _input = "";
        output = "0";
      } else if (value == "=") {
        try {
          // Basic calculation using dart:core expression
          output = _evaluate(_input);
          _input = output;
        } catch (e) {
          output = "Error";
        }
      } else {
        _input += value;
        output = _input;
      }
    });
  }

  // Simple evaluator for +, -, *, /
  String _evaluate(String expression) {
    // This is basic: for more complex you can use "math_expressions" package
    // For now only supports simple 2-number operations
    if (expression.contains("+")) {
      var parts = expression.split("+");
      return (double.parse(parts[0]) + double.parse(parts[1])).toString();
    } else if (expression.contains("-")) {
      var parts = expression.split("-");
      return (double.parse(parts[0]) - double.parse(parts[1])).toString();
    } else if (expression.contains("*")) {
      var parts = expression.split("*");
      return (double.parse(parts[0]) * double.parse(parts[1])).toString();
    } else if (expression.contains("/")) {
      var parts = expression.split("/");
      return (double.parse(parts[0]) / double.parse(parts[1])).toString();
    }
    return expression;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Calculator",
          )),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color(0xff080808),
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                output,
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const Divider(height: 1),
          Column(
            children: [
              Container(
                color: Color(0xff080808),
                child: Column(
                  children: [
                    _buildButtonRow(["7", "8", "9", "/"]),
                    _buildButtonRow(["4", "5", "6", "*"]),
                    _buildButtonRow(["1", "2", "3", "-"]),
                    _buildButtonRow(["C", "0", "=", "+"]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((btn) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              onPressed: () => _buttonPressed(btn),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(btn, style: const TextStyle(fontSize: 24)),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

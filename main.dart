import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'S_Calculator',
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "";
  String _history = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _clear();
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      _selectOperator(buttonText);
    } else if (buttonText == "=") {
      _calculate();
    } else {
      _appendToOutput(buttonText);
    }
  }

  void _clear() {
    setState(() {
      _output = "";
      _num1 = 0;
      _num2 = 0;
      _operator = "";
    });
  }

  void _selectOperator(String operator) {
    setState(() {
      _operator = operator;
      _num1 = double.parse(_output);
      _output = "";
    });
  }

  void _appendToOutput(String value) {
    setState(() {
      _output += value;
    });
  }

  void _calculate() {
    if (_operator.isEmpty || _output.isEmpty) {
      return;
    }

    _num2 = double.parse(_output);
    double result;

    switch (_operator) {
      case "+":
        result = _num1 + _num2;
        break;
      case "-":
        result = _num1 - _num2;
        break;
      case "*":
        result = _num1 * _num2;
        break;
      case "/":
        result = _num1 / _num2;
        break;
      default:
        return;
    }

    setState(() {
      _output = result.toString();
      _history += _num1.toString() +
          " " +
          _operator +
          " " +
          _num2.toString() +
          " = " +
          _output +
          "\n";
      _num1 = result;
      _num2 = 0;
      _operator = "";
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(padding: EdgeInsets.all(24.0)),
        onPressed: () => _buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _output,
                    style:
                        TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    _history,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("/"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("*"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("C"),
              _buildButton("0"),
              _buildButton("="),
              _buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }
}

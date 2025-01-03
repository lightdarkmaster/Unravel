import 'package:flutter/material.dart';

class ProgrammerCalculator extends StatefulWidget {
  const ProgrammerCalculator({super.key});

  @override
  _ProgrammerCalculatorState createState() => _ProgrammerCalculatorState();
}

class _ProgrammerCalculatorState extends State<ProgrammerCalculator> {
  String _display = '0';
  int _value = 0;

  void _onPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _display = '0';
        _value = 0;
      } else if (buttonText == 'DEL') {
        _display = _display.length > 1 ? _display.substring(0, _display.length - 1) : '0';
        _value = int.parse(_display, radix: 16);
      } else if (buttonText == '=') {
        _value = int.parse(_display, radix: 16);
      } else if (buttonText == 'BIN') {
        _display = _value.toRadixString(2);
      } else {
        if (_display == '0') {
          _display = buttonText;
        } else {
          _display += buttonText;
        }
        _value = int.parse(_display, radix: 16);
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Card(
      margin: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: 40, // Reduced width
        height: 40, // Reduced height
        child: ElevatedButton(
          onPressed: () => _onPressed(buttonText),
          child: Text(buttonText, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programmer Calculator', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(20.0),
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(14),
                child: Text(
                  _display,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <String>[
                'A', 'B', 'C', 'D',
                'E', 'F', '1', '2',
                '3', '4', '5', '6',
                '7', '8', '9', '0',
                'C', 'DEL', '=', 'BIN'
              ].map((buttonText) => _buildButton(buttonText)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

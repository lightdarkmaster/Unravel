import 'package:flutter/material.dart';

class MeasurementsPage extends StatefulWidget {
  const MeasurementsPage({super.key});

  @override
  _MeasurementsPageState createState() => _MeasurementsPageState();
}

class _MeasurementsPageState extends State<MeasurementsPage> {
  final TextEditingController _inputController = TextEditingController();
  String _fromUnit = 'meters';
  String _toUnit = 'kilometers';
  double _result = 0.0;

  void _convert() {
    double input = double.tryParse(_inputController.text) ?? 0.0;
    setState(() {
      if (_fromUnit == 'meters' && _toUnit == 'kilometers') {
        _result = input / 1000;
      } else if (_fromUnit == 'kilometers' && _toUnit == 'meters') {
        _result = input * 1000;
      } else if (_fromUnit == 'meters' && _toUnit == 'miles') {
        _result = input / 1609.34;
      } else if (_fromUnit == 'miles' && _toUnit == 'meters') {
        _result = input * 1609.34;
      } else if (_fromUnit == 'kilometers' && _toUnit == 'miles') {
        _result = input / 1.60934;
      } else if (_fromUnit == 'miles' && _toUnit == 'kilometers') {
        _result = input * 1.60934;
      }
      // Add more conversion logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measurements Converter', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _inputController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter value',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _fromUnit,
                            onChanged: (String? newValue) {
                              setState(() {
                                _fromUnit = newValue!;
                              });
                            },
                            items: <String>['meters', 'kilometers', 'miles']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              labelText: 'From',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _toUnit,
                            onChanged: (String? newValue) {
                              setState(() {
                                _toUnit = newValue!;
                              });
                            },
                            items: <String>['meters', 'kilometers', 'miles']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              labelText: 'To',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _convert,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Change this to your desired color
                      ),
                      child: const Text('Convert', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Result: $_result',
                  style: const TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
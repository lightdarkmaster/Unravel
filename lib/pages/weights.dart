import 'package:flutter/material.dart';

class WeightConverterPage extends StatefulWidget {
  const WeightConverterPage({super.key});

  @override
  _WeightConverterPageState createState() => _WeightConverterPageState();
}

class _WeightConverterPageState extends State<WeightConverterPage> {
  final TextEditingController _controller = TextEditingController();
  double _inputValue = 0.0;
  String _fromUnit = 'Kilograms';
  String _toUnit = 'Pounds';
  double _result = 0.0;

  final Map<String, double> _conversionRates = {
    'Kilograms': 1.0,
    'Pounds': 2.20462,
    'Grams': 1000.0,
    'Ounces': 35.274,
  };

  void _convert() {
    setState(() {
      double fromRate = _conversionRates[_fromUnit]!;
      double toRate = _conversionRates[_toUnit]!;
      _result = (_inputValue * toRate) / fromRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Converter', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter weight',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _inputValue = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          value: _fromUnit,
                          onChanged: (String? newValue) {
                            setState(() {
                              _fromUnit = newValue!;
                            });
                          },
                          items: _conversionRates.keys.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const Text('to'),
                        DropdownButton<String>(
                          value: _toUnit,
                          onChanged: (String? newValue) {
                            setState(() {
                              _toUnit = newValue!;
                            });
                          },
                          items: _conversionRates.keys.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity, // Adjust the width as needed
                      child: ElevatedButton(
                        onPressed: _convert,
                        child: const Text('Convert'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Result: $_result $_toUnit',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
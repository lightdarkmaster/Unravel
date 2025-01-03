import 'package:flutter/material.dart';

class HeightConverterPage extends StatefulWidget {
  const HeightConverterPage({super.key});

  @override
  _HeightConverterPageState createState() => _HeightConverterPageState();
}

class _HeightConverterPageState extends State<HeightConverterPage> {
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _inchesController = TextEditingController();
  double _height = 0.0;
  String _selectedFromUnit = 'ft';
  String _selectedToUnit = 'cm';

  @override
  void initState() {
    super.initState();
    _feetController.addListener(_convertHeight);
    _inchesController.addListener(_convertHeight);
  }

  @override
  void dispose() {
    _feetController.removeListener(_convertHeight);
    _inchesController.removeListener(_convertHeight);
    _feetController.dispose();
    _inchesController.dispose();
    super.dispose();
  }

  void _convertHeight() {
    double heightInCm = 0.0;

    switch (_selectedFromUnit) {
      case 'ft':
        final int feet = int.tryParse(_feetController.text) ?? 0;
        final int inches = int.tryParse(_inchesController.text) ?? 0;
        heightInCm = (feet * 30.48) + (inches * 2.54);
        break;
      case 'cm':
        heightInCm = double.tryParse(_feetController.text) ?? 0.0;
        break;
      case 'm':
        heightInCm = (double.tryParse(_feetController.text) ?? 0.0) * 100;
        break;
      case 'in':
        heightInCm = (double.tryParse(_feetController.text) ?? 0.0) * 2.54;
        break;
    }

    setState(() {
      switch (_selectedToUnit) {
        case 'cm':
          _height = heightInCm;
          break;
        case 'm':
          _height = heightInCm / 100;
          break;
        case 'in':
          _height = heightInCm / 2.54;
          break;
        case 'ft':
          _height = heightInCm / 30.48;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Height Converter', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _feetController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter Data',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedFromUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFromUnit = newValue!;
                        });
                        _convertHeight();
                      },
                      decoration: InputDecoration(
                        labelText: 'From Unit',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      items: <String>['ft', 'cm', 'm', 'in']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedToUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedToUnit = newValue!;
                        });
                        _convertHeight();
                      },
                      decoration: InputDecoration(
                        labelText: 'To Unit',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      items: <String>['cm', 'm', 'in', 'ft']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _convertHeight,
                      style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 100),
                      backgroundColor: Colors.blueAccent,
                      ),
                      child: const Text('Convert', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Height in $_selectedToUnit: $_height',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BinaryToWordPage extends StatefulWidget {
  const BinaryToWordPage({super.key});

  @override
  _BinaryToWordPageState createState() => _BinaryToWordPageState();
}

class _BinaryToWordPageState extends State<BinaryToWordPage> {
  final TextEditingController _controller = TextEditingController();
  String _binaryOutput = '';

  void _convertToBinary() {
    setState(() {
      _binaryOutput = _controller.text
          .runes
          .map((int rune) => rune.toRadixString(2).padLeft(8, '0'))
          .join(' ');
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _binaryOutput));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word to Binary Converter', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Enter text',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _convertToBinary,
                      child: const Text('Convert to Binary'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SelectableText(
                          _binaryOutput,
                          style: const TextStyle(fontSize: 12),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: _copyToClipboard,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
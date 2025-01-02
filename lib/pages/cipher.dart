import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/services.dart';

class CipherPage extends StatefulWidget {
  const CipherPage({super.key});

  @override
  _CipherPageState createState() => _CipherPageState();
}

class _CipherPageState extends State<CipherPage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  String _output = '';
  String _selectedAlgorithm = 'AES';

  void _encryptText() {
    final key = encrypt.Key.fromUtf8(_keyController.text.padRight(32));
    final iv = encrypt.IV.fromLength(16);
    final encrypter = _getEncrypter(key, iv);

    final encrypted = encrypter.encrypt(_textController.text, iv: iv);
    setState(() {
      _output = encrypted.base64;
    });
  }

  void _decryptText() {
    final key = encrypt.Key.fromUtf8(_keyController.text.padRight(32));
    final iv = encrypt.IV.fromLength(16);
    final encrypter = _getEncrypter(key, iv);

    final decrypted = encrypter.decrypt64(_output, iv: iv);
    setState(() {
      _output = decrypted;
    });
  }

  encrypt.Encrypter _getEncrypter(encrypt.Key key, encrypt.IV iv) {
    switch (_selectedAlgorithm) {
      case 'AES':
        return encrypt.Encrypter(encrypt.AES(key));
      case 'Fernet':
        return encrypt.Encrypter(encrypt.Fernet(key));
      default:
        return encrypt.Encrypter(encrypt.AES(key));
    }
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _output));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cipher Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Instructions:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('1. Enter the text you want to encrypt or decrypt.',style: TextStyle(fontSize: 10)),
                    Text('2. Enter a key for encryption/decryption.',style: TextStyle(fontSize: 10)),
                    Text('3. Select the algorithm (AES or Fernet).',style: TextStyle(fontSize: 10)),
                    Text('4. Press "Encrypt" to encrypt the text.',style: TextStyle(fontSize: 10)),
                    Text('5. Press "Decrypt" to decrypt the text.',style: TextStyle(fontSize: 10)),
                    Text('6. Use the copy button to copy the output to clipboard.',style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(labelText: 'Enter text'),
                    ),
                    TextField(
                      controller: _keyController,
                      decoration: const InputDecoration(labelText: 'Enter key'),
                    ),
                    DropdownButton<String>(
                      value: _selectedAlgorithm,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedAlgorithm = newValue!;
                        });
                      },
                      items: <String>['AES', 'Fernet']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _encryptText,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Background color
                          ),
                          child: const Text('Encrypt', style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: _decryptText,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Background color
                          ),
                          child: const Text('Decrypt', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Output: $_output', style: const TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: _copyToClipboard,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
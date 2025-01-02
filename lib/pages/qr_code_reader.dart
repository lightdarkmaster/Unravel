import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRVieweReader extends StatefulWidget {
  const QRVieweReader({super.key});

  @override
  State<StatefulWidget> createState() => _QRVieweReaderState();
}

class _QRVieweReaderState extends State<QRVieweReader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.deepPurple,
              child: Center(
                child: (result != null)
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Barcode Type: ${result!.format}',
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'Data: ${result!.code}',
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.copy),
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: result!.code ?? ''));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Copied to Clipboard')),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Text(
                        'Scan a code',
                        style: TextStyle(fontSize: 18.0),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
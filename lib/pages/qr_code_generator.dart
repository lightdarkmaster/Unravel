import 'package:custom_qr_generator/colors/color.dart';
import 'package:custom_qr_generator/custom_qr_generator.dart' as custom_qr;
import 'package:custom_qr_generator/options/colors.dart';
import 'package:custom_qr_generator/options/options.dart';
import 'package:custom_qr_generator/options/shapes.dart';
import 'package:custom_qr_generator/shapes/ball_shape.dart';
import 'package:custom_qr_generator/shapes/frame_shape.dart';
import 'package:custom_qr_generator/shapes/pixel_shape.dart';
import 'package:flutter/material.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QRGeneratorState createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  final TextEditingController _controller = TextEditingController();
  String _data = 'Sample Flutter QR Code by: LightDarkmaster';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          labelText: 'Enter data for QR code',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _data = _controller.text;
                          });
                        },
                        child: const Text('Generate QR Code'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomPaint(
                    painter: custom_qr.QrPainter(
                      data: _data,
                      options: const QrOptions(
                        shapes: QrShapes(
                          darkPixel: QrPixelShapeRoundCorners(cornerFraction: .5),
                          frame: QrFrameShapeRoundCorners(cornerFraction: .25),
                          ball: QrBallShapeRoundCorners(cornerFraction: .25),
                        ),
                        colors: QrColors(
                          dark: QrColorLinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 0, 0),
                              Color.fromARGB(255, 0, 0, 255),
                            ],
                            orientation: GradientOrientation.leftDiagonal,
                          ),
                        ),
                      ),
                    ),
                    size: const Size(350, 350),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

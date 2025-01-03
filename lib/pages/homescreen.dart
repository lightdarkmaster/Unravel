import 'package:flutter/material.dart';
import 'package:unravel/pages/binary_to_word.dart';
import 'package:unravel/pages/cipher.dart';
import 'package:unravel/pages/heights.dart';
import 'package:unravel/pages/measurements.dart';
import 'package:unravel/pages/programmer_cal.dart';
import 'package:unravel/pages/qr_code_generator.dart';
import 'package:unravel/pages/qr_code_reader.dart';
import 'package:unravel/pages/weights.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unravel', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(9, (index) {
            return Padding(
              padding: const EdgeInsets.all(5.0), // Add padding around each card
              child: GestureDetector(
                onTap: () {
                  // Navigate to different pages based on index
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => getPage(index)),
                  );
                },
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        getImagePath(index), // Use different images
                        width: 50.0,
                        height: 50.0,
                      ),
                      const SizedBox(height: 8.0),
                      Text(getLabel(index)), // Use different labels
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget getPage(int index) {
    // Return different pages based on index
    switch (index) {
      case 0:
        return const QRVieweReader();
      case 1:
        return const QRGenerator();
      case 2:
        return const CipherPage();
      case 3:
        return const BinaryToWordPage();
      case 4:
        return const ProgrammerCalculator();
      case 5:
        return const MeasurementsPage();
      case 6:
        return const WeightConverterPage();
      case 7:
        return const HeightConverterPage();
      default:
        return const HomeScreen();
    }
  }

  String getImagePath(int index) {
    // Return different image paths based on index
    switch (index) {
      case 0:
        return 'assets/icons/qr_scanner.png';
      case 1:
        return 'assets/icons/qr_generator.png';
      case 2:
        return 'assets/icons/cipher.png';
      case 3:
        return 'assets/icons/binary.png';
      case 4:
        return 'assets/icons/programmer_cal.png';
      case 5:
        return 'assets/icons/measurements.png';
      case 6:
        return 'assets/icons/weights.png';
      case 7:
        return 'assets/icons/heights.png';
      case 8:
        return 'assets/icons/cipher.png';
      default:
        return 'assets/icons/cipher.png';
    }
  }

  String getLabel(int index) {
    // Return different labels based on index
    switch (index) {
      case 0:
        return 'QR Scanner';
      case 1:
        return 'QR Generator';
      case 2:
        return 'Cipher';
      case 3:
        return 'Binary';
      case 4:
        return 'Prog Cal';
      case 5:
        return 'Measurements';
      case 6:
        return 'Weights';
      case 7:
        return 'Heights';
      case 8:
        return 'Email';
      default:
        return 'Unknown';
    }
  }
}

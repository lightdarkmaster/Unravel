import 'package:flutter/material.dart';
import 'package:unravel/pages/cipher.dart';
import 'package:unravel/pages/qr_code_generator.dart';
import 'package:unravel/pages/qr_code_reader.dart';

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
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(9, (index) {
            return GestureDetector(
              onTap: () {
                // Navigate to different pages based on index
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => getPage(index)),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    getIcon(index), // Use different icons
                    size: 50.0,
                  ),
                  const SizedBox(height: 8.0),
                  Text(getLabel(index)), // Use different labels
                ],
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
      default:
        return const HomeScreen();
    }
  }

  IconData getIcon(int index) {
    // Return different icons based on index
    switch (index) {
      case 0:
        return Icons.qr_code_scanner;
      case 1:
        return Icons.qr_code;
      case 2:
        return Icons.code;
      case 3:
        return Icons.settings;
      case 4:
        return Icons.person;
      case 5:
        return Icons.map;
      case 6:
        return Icons.camera;
      case 7:
        return Icons.phone;
      case 8:
        return Icons.email;
      default:
        return Icons.ac_unit;
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
        return 'Cipher Page';
      case 3:
        return 'Settings';
      case 4:
        return 'Profile';
      case 5:
        return 'Map';
      case 6:
        return 'Camera';
      case 7:
        return 'Phone';
      case 8:
        return 'Email';
      default:
        return 'Unknown';
    }
  }
}

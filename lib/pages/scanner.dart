import 'package:currencyscanner/screens/scannerscreen.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ScannerPage extends StatelessWidget {
  static const String namedRoute = 'scannerpage';
  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScannerScreen(cameras);
  }
}
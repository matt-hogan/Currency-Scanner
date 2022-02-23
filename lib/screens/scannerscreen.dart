import 'package:camera/camera.dart';
import 'package:currencyscanner/screens/camerascreen.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:currencyscanner/pages/home/widgets/storage.dart';


import '../main.dart';

class ScannerScreen extends StatefulWidget {
  List<CameraDescription>? cameras;

  ScannerScreen(cameras);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  @override
  void initState() {
    loadModel();
    super.initState();
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/tflite/model.tflite",
        labels: "assets/tflite/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return CameraScreen(cameras: cameras, storage: Storage());
  }
}
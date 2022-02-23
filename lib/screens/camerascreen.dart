import 'dart:async';
import 'package:currencyscanner/pages/home/model/recognition.dart';
import 'package:currencyscanner/pages/home/widgets/detect_info.dart';
import 'package:currencyscanner/pages/home/widgets/scan_widget.dart';
import 'package:currencyscanner/pages/home/widgets/storage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import '../main.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;
  final Storage storage;

  CameraScreen({Key? key, required this.cameras, required this.storage}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  late CameraController? controller;
  bool isDetecting = false;
  int cameraSelected = 0;
  late List op;
  late Future<void> _initializeControllerFuture;
  late String outputMoney;
  late int totalMoney;

  Recognition recognition =
  Recognition(confidence: 0.0, index: 0, label: '  Loading');

  setRecognitions(List recognitions) {
    if (recognitions.isNotEmpty) {
      setState(() {
        recognition =
            Recognition.fromJson(Map<String, dynamic>.from(recognitions.first));
        widget.storage.writeData(recognition.getAmountScanned());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (cameras == null || cameras!.isEmpty) {
      print('No camera is found');
    } else {
      controller = CameraController(
          cameras![cameraSelected], ResolutionPreset.high,
          enableAudio: false);
      initRecord();
    }
  }

  void initRecord() {
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      controller!.startImageStream((CameraImage img) async {
        if (!isDetecting) {
          isDetecting = true;
          await Future.delayed(const Duration(seconds: 2));
          Tflite.runModelOnFrame(
            bytesList: img.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: img.height,
            imageWidth: img.width,
            imageMean: 127.5,
            imageStd: 127.5,
            numResults: 3,
            threshold: 0.1,
            asynch: true,
          ).then((recognitions) {
            setRecognitions(recognitions!);
            isDetecting = false;
          });
        }
      });
    });
  }

  Future<void> stopRecord() async {
    await controller!.stopImageStream();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Stack(
        children: [
          OverflowBox(
            child: CameraPreview(controller!),
          ),
          Positioned(
              bottom: 1, right: 1, left: 1, child: ScanWidget(recognition: recognition))
        ],
      ),
    );
  }
}
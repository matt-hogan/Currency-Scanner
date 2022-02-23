import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class Recognition {
  String label;
  double confidence;
  int index;

  Recognition({required this.label, required this.confidence, required this.index});

  factory Recognition.fromJson(Map<String, dynamic> json) {
    return Recognition(
        label: json['label'] ?? 'Error',
        confidence: json['confidence'] ?? 0.1,
        index: json['index'] ?? 12,
    );
  }

  String getAmountScanned () {
    return "$label,$confidence,";
  }
}


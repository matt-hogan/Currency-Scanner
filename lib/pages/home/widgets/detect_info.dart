import 'package:flutter/material.dart';
import 'package:currencyscanner/pages/home/model/recognition.dart';
import 'package:currencyscanner/pages/home/widgets/status_image.dart';
import 'package:currencyscanner/pages/home/widgets/status_widget.dart';

class DetectInfo extends StatelessWidget {
  DetectInfo(this.recognition);
  final Recognition recognition;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [/*StatusImage(index: recognition.index!)*/Status(recognition)],
      ),
    );
  }
}
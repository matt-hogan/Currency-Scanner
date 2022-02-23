import 'package:flutter/material.dart';
import 'package:currencyscanner/pages/home/model/recognition.dart';
import 'package:currencyscanner/pages/home/widgets/percent_indicator.dart';
import 'package:currencyscanner/pages/home/widgets/status_text.dart';

class Status extends StatelessWidget {
  const Status(
      this.recognition, {
        Key? key,
      }) : super(key: key);

  final Recognition recognition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StatusText(recognition.label),
          PercentIndicator(recognition.confidence),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:currencyscanner/core/core.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentIndicator extends StatelessWidget {
  const PercentIndicator(
      this.confidence, {
        Key? key,
      }) : super(key: key);
  final double confidence;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: LinearPercentIndicator(
        width: 280,
        animation: true,
        lineHeight: 25.0,
        percent: confidence,
        center: Text("${(confidence * 100).toStringAsFixed(2)}%"),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: neonGreen,
      ),
    );
  }
}
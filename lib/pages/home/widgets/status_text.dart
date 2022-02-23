import 'package:flutter/material.dart';
import 'package:currencyscanner/core/core.dart';

class StatusText extends StatelessWidget {
  const StatusText(
      this.label, {
        Key? key,
      }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(400),
          color: neonGreen,
          border: Border.all(
            color: Colors.black,
            width: 4.0,
          )
      ),
      height: 80,
      width: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label.substring(2), textAlign: TextAlign.center, style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: black)),
          ],
        ),
      ),
    );
  }
}
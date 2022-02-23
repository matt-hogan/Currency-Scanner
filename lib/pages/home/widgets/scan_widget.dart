import 'dart:convert';

import 'package:currencyscanner/pages/home/widgets/storage.dart';
import 'package:flutter/material.dart';
import 'package:currencyscanner/pages/home/model/recognition.dart';
import 'package:currencyscanner/core/app_colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:currencyscanner/pages/home/widgets/storage.dart';

class ScanWidget extends StatefulWidget {
  const ScanWidget({Key? key, required this.recognition}) : super(key: key);
  final Recognition recognition;

  @override
  _ScanWidgetState createState() => _ScanWidgetState();
}

class _ScanWidgetState extends State<ScanWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    // shows recognition
                    _contentWidget()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentWidget() {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    print(widget.recognition.label);
    print(widget.recognition.confidence);

    if (widget.recognition.confidence != null) {
      if (widget.recognition.confidence >= .80) {
        var _recognitionDollar = widget.recognition.label;
        var _recognitionPercent = (widget.recognition.confidence * 100)
            .toStringAsFixed(0) + '%';

        return Container(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: neonGreen,
                  border: Border.all(
                    color: Colors.black,
                    width: 4.0,
                  ),
                ),
                height: 80,
                width: _width * .75,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _recognitionDollar,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: black
                        )
                      )
                    ],
                  )
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: _width * .15, top: _height * .01),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LinearPercentIndicator(
                        width: _width * .70,
                        animation: false,
                        lineHeight: 25.0,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: neonGreen,
                        percent: widget.recognition.confidence,
                        center: Text(
                          _recognitionPercent,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            color: black
                          )
                        )
                      )
                    ],
                  )
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: neonGreen,
                  border: Border.all(
                    color: Colors.black,
                    width: 4.0,
                  ),
                ),
                height: 80,
                width: _width * .75,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: Future.delayed(Duration(milliseconds: 500)),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Text(
                              "Scanning",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: black
                              )
                            );
                          } else {
                            return FutureBuilder(
                              future: Future.delayed(Duration(milliseconds: 500)),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Text(
                                    "Scanning.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: black
                                    )
                                  );
                                } else {
                                  return FutureBuilder(
                                    future: Future.delayed(Duration(milliseconds: 500)),
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Text(
                                          "Scanning..",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: black
                                          )
                                        );
                                      } else {
                                        return const Text(
                                          "Scanning...",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: black
                                          )
                                        );
                                      }
                                    },
                                  );
                                }
                              },
                            );
                          }
                        },
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        );
      }
    }
    return const Text("");
  }
}
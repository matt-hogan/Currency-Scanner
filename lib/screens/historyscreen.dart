import 'dart:ffi';

import 'package:currencyscanner/pages/home/model/recognition.dart';
import 'package:currencyscanner/pages/home/widgets/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key, required this.storage}) : super(key: key);
  final Storage storage;

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ///List that holds the double values for the money
  final List<double> _data = <double> [];

  ///This isn't needed for the main code but leaving
  ///it in for now until addValue() is changed so it doesn't
  ///cause it to error out

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => getHistory());
  }

  void rewriteStorage (int index) {
    setState(() {
      _data.removeAt(index);
      widget.storage.rewriteStorage(_data);
    });
  }

  ///This is where the setState should go for the file save
  ///the only important part about the code is _data.add
  void addValue(double newValue) {
    setState(() {
      _data.add(newValue);
    });
  }

  ///will be needed for the saving of the file
  double sumValue() {
    double value;
    double total = 0;

    //checks if the _data is empty
    if (_data.isEmpty) {
      return total;
    } else {
      //goes through the whole list and adds the values together
      for (var i = 0; i <= _data.length - 1; i++) {
        value = _data.elementAt(i);
        total = total + value;
      }
    }
    return total;
  }

  Future<List<double>> getHistory () async {
    List<double> labelValues = [];

    await widget.storage.readData().then((String result) {
      String allScans = result.toString();
      String withoutDollar = allScans.replaceAll(r"$", "");
      List<String> listOfScansUnordered = withoutDollar.split(',');

      List<String> scanLabel = [];
      List<String> scanConfidence = [];
      List<List<String>> listOfScans = [ scanLabel, scanConfidence ];

      for (int i = 0; i < listOfScansUnordered.length; i++) {
        if (i % 2 == 0) {
          scanLabel.add(listOfScansUnordered[i]);
        } else{
          scanConfidence.add(listOfScansUnordered[i]);
        }
      }

      List<String> scanLabelNew = [];
      List<String> scanConfidenceNew = [];
      if (scanLabel.isNotEmpty) {
        for (int i = 0; i < scanLabel.length; i++) {
          double confidence = 0;
          if (scanConfidence.isEmpty) {
            continue;
          }
          if (i == scanLabel.length - 1 && scanLabel.length != 1) {
            confidence = double.parse(scanConfidence[i-1]);
          } else {
            confidence = double.parse(scanConfidence[i]);
          }
          if (scanLabelNew.isEmpty) {
            if (confidence < 0.8) {
              continue;
            }
            scanLabelNew.add(scanLabel[i]);
            scanConfidenceNew.add(scanConfidence[i]);
          } else if (scanLabel[i] != scanLabel[i - 1]) {
            if (confidence < 0.8) {
              continue;
            }
            scanLabelNew.add(scanLabel[i]);
            if (i == scanLabel.length - 1) {
              continue;
            } else {
              scanConfidenceNew.add(scanConfidence[i]);
            }
          }
        }
      }
      listOfScans = [ scanLabelNew, scanConfidenceNew ];

      for (int i = 0; i < listOfScans[0].length; i++) {
        List<String> labels = [ "1.00", "2.00", "5.00", "10.00," "20.00", "50.00", "100.00"];
        String stringValue = "";

        stringValue = listOfScans[0][i];

        for (String s in labels) {
          if (s == stringValue) {
            print(stringValue);
            double value = double.parse(stringValue);

            labelValues.add(value);
          }
        }

      }

      for (double i in labelValues) {
        addValue(i);
      }

    });

    return labelValues;
  }

  bool selected = true;

  @override
  Widget build (BuildContext context) {
    return Column (
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.greenAccent, Color(0xff03881d)]),
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //the ${sumValue()} is how we ge the total to show in the text
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0,5.0,4.0,0.0),
                    child: Text("Total Amount", style: TextStyle(fontWeight: FontWeight.bold, color : Colors.black, fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0,5.0,4.0,0.0),
                    child: Text("\$${sumValue().toStringAsFixed(2)}", style: GoogleFonts.orbitron(color : Colors.black, fontSize: 40, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ),
        ),

        //button for clear the list
        Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                //Yeah you can edit the button how you want I am messing around
                primary: Colors.greenAccent[400],
                padding: EdgeInsets.all(12),
                textStyle: TextStyle(fontSize: 22),
              ),
              child: Text('Clear List', style: GoogleFonts.oxygen(color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {
                setState(() {
                  _data.clear();
                  widget.storage.clearData();
                });
              },
            ),
          ),
        ),
        //Text("SCAN HISTORY", style: TextStyle(fontWeight: FontWeight.bold, color : Colors.white),),
        Expanded(
          child: ListView.builder(
            //scroll and shrinkWrap help with the list as it grows down
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            //this is need to grab the length of the list for dismissible
            //and also for ListView.builder
            itemCount: _data.length,
            itemBuilder: (context, index){
              //grabs the first item's current index
              String item = _data[index].toString();
              item += "0";
              return Dismissible(
                // Each Dismissible must contain a Key. Keys allow Flutter to
                // uniquely identify widgets.
                key: UniqueKey(),
                // Provide a function that tells the app
                // what to do after an item has been swiped away.
                onDismissed: (direction) {
                  rewriteStorage(index);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(55, 65, 104, 1),
                    ),
                    child: ListTile(
                      leading: IconButton (
                        icon: Icon(selected ? Icons.delete : Icons.title),
                        tooltip: 'Delete',
                        onPressed: () {
                          rewriteStorage(index);
                        },
                      ),
                      //item.toString takes the double value from _data and converts it to a string
                      title: Text("Amount: \$" + item, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color : Colors.white),),
                      //subtitle: Text("Amount scanned was $index", style: TextStyle(color : Colors.white),),
                      contentPadding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                      trailing: Text("USD", style: TextStyle(fontWeight: FontWeight.bold, color : Colors.greenAccent),),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  } //widget
}
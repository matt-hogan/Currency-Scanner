import 'package:currencyscanner/core/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Row(
              children: const [
                Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text("App Settings", style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            const SizedBox(height: 10),
            buildAccountOption(context, "Currency Type"),
            const SizedBox(height: 40),
            Row(
              children: const [
                Icon(Icons.settings_accessibility_rounded, color: neonGreen),
                SizedBox(width: 10),
                Text("Accessibility", style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ))
              ],
            ),
            const Divider(height: 20, thickness: 1),
            const SizedBox(height: 10),
            buildNotificationOption(
                "Vibration mode", valNotify2, onChangeFunction2
            ),
            buildNotificationOption(
                "Display amount on screen", valNotify3, onChangeFunction3
            ),
            const SizedBox(height: 50),

          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(String title, bool value,
      Function onChangeMethod) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]
              )),
              Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    activeColor: neonGreen,
                    trackColor: Colors.grey,
                    value: value,
                    onChanged: (bool newValue) {
                      onChangeMethod(newValue);
                    },
                  )
              )
            ]
        )
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("US dollar", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                Text("Canadian dollar", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                Text("Mexican peso", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                Text("British pound", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              )
            ],
          );
        });
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600]
                )),
                const Icon(Icons.arrow_forward_ios, color: Colors.grey)
              ],
            ),
          )
      ),
    );
  }
}
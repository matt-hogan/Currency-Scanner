import 'package:flutter/cupertino.dart';
import 'package:currencyscanner/screens/settingsscreen.dart';

class SettingsPage extends StatelessWidget {
  static const String namedRoute = 'settingspage';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsScreen();
  }
}
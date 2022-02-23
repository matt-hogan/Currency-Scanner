import 'package:flutter/cupertino.dart';
import 'package:currencyscanner/screens/historyscreen.dart';
import 'package:currencyscanner/pages/home/widgets/storage.dart';

class HistoryPage extends StatelessWidget {
  static const String namedRoute = 'historypage';
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HistoryScreen(storage: Storage());
  }
}
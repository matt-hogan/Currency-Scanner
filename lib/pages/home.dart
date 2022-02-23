import 'package:currencyscanner/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:currencyscanner/pages/history.dart';
import 'package:currencyscanner/pages/scanner.dart';
import 'package:currencyscanner/pages/settings.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int currentIndex = 1;

  final List<Widget> _widgets = [
    HistoryPage(),
    ScannerPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: black,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        itemPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        items: [
          SalomonBottomBarItem(
            selectedColor: neonGreen,
            unselectedColor: white,
            icon: const Icon(
              Feather.archive,
              size: 26,
            ),
            title: const Text('History'),
          ),
          SalomonBottomBarItem(
            selectedColor: neonGreen,
            unselectedColor: white,
            icon: const Icon(
              Feather.camera,
              size: 26,
            ),
            title: const Text('Scanner'),
          ),
          SalomonBottomBarItem(
            selectedColor: neonGreen,
            unselectedColor: white,
            icon: const Icon(
              Feather.settings,
              size: 26,
            ),
            title: const Text('Settings'),
          )
        ],
      ),
      body: _widgets[currentIndex],
    ));
  }
}
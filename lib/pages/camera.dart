import 'package:currencyscanner/screens/camerascreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:currencyscanner/pages/home/widgets/storage.dart';

import '../main.dart';

class CameraPage extends StatelessWidget {
  static const String namedRoute = 'camerapage';
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CameraScreen(cameras: cameras, storage: Storage());
  }
}
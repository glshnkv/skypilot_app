import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skypilot_app/skypilot_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(SkyPilotApp());
}

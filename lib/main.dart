import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/flavor_config.dart';

import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (BuildContext context) => MyApp(),
  // ));

  final flavorString =
      await const MethodChannel("flavor").invokeMethod<String>("getFlavor");

  if (kDebugMode) {
    print("flavor string $flavorString");
  }

  runApp(MaterialApp(
      home: MyHomePage(
    title: flavorString ?? "Null",
  )));
}

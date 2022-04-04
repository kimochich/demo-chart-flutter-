import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_project/flavor_config.dart';

import 'pages/home_page.dart';

void main() {
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (BuildContext context) => MyApp(),
  // ));

  final config = FlavorConfig(
      appTitle: "App product",
      env: EnvEnum.prod,
      variables: {VariableEnum.baseUrl: "1123"});

  runApp(MaterialApp(home: MyHomePage(title: config.appTitle,)));
}

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/flavor_config.dart';

import 'pages/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final config = FlavorConfig(
      appTitle: "App dev",
      env: EnvEnum.dev,
      variables: {VariableEnum.baseUrl: "1123"});

  final flavorString = await  const MethodChannel("flavor").invokeMethod<String>("getFlavor");
  print("flavor string $flavorString");

  runApp(MaterialApp(home: MyHomePage(title: config.appTitle,)));
}

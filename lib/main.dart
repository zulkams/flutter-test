import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/app.dart';
import 'package:flutter_test_myeg/core/dependency_injection/dependency_injection.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DI
  await setupDependencies();
  runApp(const MyApp());
}

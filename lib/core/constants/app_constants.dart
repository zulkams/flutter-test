// baseurl from env

import 'package:flutter_dotenv/flutter_dotenv.dart';

// netwoek
String baseUrl = dotenv.env['BASE_URL'] ?? "";
Duration connectTimeout = const Duration(seconds: 10);
Duration receiveTimeout = const Duration(seconds: 15);

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rize/controller/routing/app_router.dart';
import 'package:rize/rize_app.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(RizeApp(
    appRouter: AppRouter(),
  ));
}

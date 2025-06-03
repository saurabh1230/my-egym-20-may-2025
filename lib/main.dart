import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/helper/route_helper.dart';
import 'package:myegym/utils/app_constants.dart';
import 'package:myegym/utils/theme/light_theme.dart';
import 'helper/gi_dart.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await di.init();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: light,
      initialRoute: RouteHelper.getInitialRoute(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      builder: (BuildContext context, widget) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!);
      },
    );
  }
}

import 'dart:io';

import 'package:clay_rigging_bridle/features/splash_screen/splash_screen.dart';
import 'package:clay_rigging_bridle/firebase_options.dart';
import 'package:clay_rigging_bridle/utils/app_labels.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      )
      : await Firebase.initializeApp();

  runApp(MyApp());
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
      title: AppLabels.appName,
      debugShowCheckedModeBanner: false,
      // initialBinding: createBindings(context),
      navigatorObservers: [routeObserver],
      home: SplashScreen(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
    );
  }
}

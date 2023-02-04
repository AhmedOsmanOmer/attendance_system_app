import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graduation_project_student/controller/app_controller.dart';
import 'package:graduation_project_student/locale.dart';
import 'package:graduation_project_student/splash.dart';
import 'package:sizer/sizer.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main(List<String> args) {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(/*DevicePreview(builder: (context) =>*/const MyApp());//);
    });
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Login_Controller lc = Login_Controller();
    return Sizer(builder: (context, orientation, devicetype) {
      return GetMaterialApp(
          theme: ThemeData(fontFamily: "Domine"),
          debugShowCheckedModeBanner: false,
          locale: lc.locale,
          translations: MyLocale(),
          home: const Splash());
    });
  }
}

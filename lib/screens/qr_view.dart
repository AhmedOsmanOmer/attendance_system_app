// ignore_for_file: camel_case_types, avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project_student/controller/app_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QR_View extends StatefulWidget {
  const QR_View({super.key});

  @override
  State<QR_View> createState() => _QR_ViewState();
}

class _QR_ViewState extends State<QR_View> {
  Login_Controller lc = Login_Controller();

  @override
  void dispose() {
    lc.controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await lc.controller!.resumeCamera();
    }
    // lc.controller!.resumeCamera();
  }

  Barcode? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<Login_Controller>(
      init: Login_Controller(),
      builder: (controller) =>
          Container(child: controller.buildQrView(context)),
    ));
  }
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_mac/get_mac.dart';
import 'package:graduation_project_student/screens/home.dart';
import 'package:graduation_project_student/screens/login_screen.dart';
import 'package:graduation_project_student/widget.dart';
import 'package:http/http.dart' as http;
import 'package:imei_plugin/imei_plugin.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sizer/sizer.dart';

class Login_Controller extends GetxController {
  var url =
      "http://172.20.10.7/graduation_project"; //"https://172.20.10.9/graduation_project";
  TextEditingController id = TextEditingController();
  var id_ = "",
      first_name = "",
      second_name = "",
      third_name = "",
      last_name = "",
      specialization = "",
      index_no = "",
      year = "",
      qr_value = "",
      subject = "",
      attendence_date = "",
      attendence_time = "";
  String imageUrl =
      "http://172.20.10.7/graduation_project/images/default.png"; //"http://172.20.10.9/graduation_project/images/default.png";
  bool visible = false;
  String phone_serial = "";
  QRViewController? qr_controller;
////
  ///
  final qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qr_result;
  Barcode barcode = Barcode("", BarcodeFormat.qrcode, []);

  ///
  ///
  Future<void> get_imei_mac() async {
    try {
      if (Platform.isAndroid) {
        phone_serial = await ImeiPlugin.getImei(
            shouldShowRequestPermissionRationale: false);
      }
      if (Platform.isIOS) {
        phone_serial = await GetMac.macAddress;
      }
    } on PlatformException {
      phone_serial = "Fail To get seial";
    }
    update();
  }

  ///
  ///
  Future login(TextEditingController id, context) async {
    //get phone serial number
    get_imei_mac();

    ///
    ///login function
    var response = await http
        .post(Uri.parse("$url/student_login.php"), body: {"id": id.text});
    var data = json.decode(response.body);
    if (data['status'] == "system_on") {
      ///
      ///login first time
      if (data['data']['serial'] == "") {
        var res = await http.post(Uri.parse("$url/serial.php"),
            body: {"serial": phone_serial, "id": id.text});
        var dat = json.decode(res.body);
        ////

        ///
        ///first login useing another student phone
        if (dat['status'] == "fail") {
          //Get.back();
          showAlertDialog(context, "warning".tr, "another_std".tr);
          /*AwesomeDialog(
            context: context,
            title: "This Device is belong to another student",
            width: 300,
          ).show();*/
        } else {
          id_ = data['data']['id'];
          first_name = data['data']['first_name'];
          second_name = data['data']['second_name'];
          third_name = data['data']['third_name'];
          last_name = data['data']['last_name'];
          specialization = data['data']['specialization'];
          index_no = data['data']['index_no'];
          year = data['data']['year'];
          imageUrl = data['data']['image_url'];
          qr_value = data['system_data']['qr_value'];
          subject = data['system_data']['subject'];
          attendence_date = data['system_data']['attendence_date'];
          attendence_time = data['system_data']['attendence_time'];
          visible = true;
          Get.to(() => const Home());
        }
      }
      if (data['data']['serial'] == phone_serial) {
        id_ = data['data']['id'];
        first_name = data['data']['first_name'];
        second_name = data['data']['second_name'];
        third_name = data['data']['third_name'];
        last_name = data['data']['last_name'];
        specialization = data['data']['specialization'];
        index_no = data['data']['index_no'];
        year = data['data']['year'];
        imageUrl = data['data']['image_url'];
        visible = true;
        qr_value = data['system_data']['qr_value'];
        subject = data['system_data']['subject'];
        attendence_date = data['system_data']['date'];
        attendence_time = data['system_data']['time'];
        Get.to(() => const Home());
      }
      if (data['data']['serial'] != phone_serial &&
          data['data']['serial'] != "") {
        showAlertDialog(context, "warning".tr, "not_you".tr);
        /*AwesomeDialog(
          context: context,
          title: "This Device is not belong to you",
          width: 300,
        ).show();*/
      }
    }
    if (data['status'] == "system_off") {
      showAlertDialog(context, "warning".tr, "system_off".tr);
      /*AwesomeDialog(
        context: context,
        title: "System is OFF ",
        width: 300,
      ).show();*/
    }
    if (data['status'] == "fail") {
      showAlertDialog(context, "warning".tr, "wrong_id".tr);
      /*AwesomeDialog(
        context: context,
        title: "Wrong ID ",
        width: 300,
      ).show();*/
    }
    update();
  }

  ////
  ///
  make_attendence() async {
    var response =
        await http.post(Uri.parse("$url/make_attendence.php"), body: {
      "id": id_,
      "first_name": first_name,
      "second_name": second_name,
      "third_name": third_name,
      "last_name": last_name,
      "specialization": specialization,
      "year": year,
      "subject": subject,
      "attendence_date": attendence_date,
      "attendence_time": attendence_time
    });

    var data = json.decode(response.body);
    if (data['status'] == "success") {
      print("success/////////////////////");
      print("//////////////////////");
      print("///////////////////////");
      Get.off(() => const LoginScreen());
      ShowToast("atttendence_success".tr);
    } else {
      print("error////////////////////");
      print("/////////////////////");
      print("//////////////////////");
      print("///////////////////////");
      Get.off(() => const LoginScreen());
      ShowToast("attendence_twice".tr);
    }
  }

  ///
  ///
  ///

  Widget buildQrView(BuildContext context) {
    return QRView(
        //cameraFacing: CameraFacing.unknown,
        key: qrkey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            cutOutSize: 40.h,
            borderWidth: 1.h,
            borderLength: 2.h,
            borderRadius: 10));
  }

  void onQRViewCreated(QRViewController controller) {
//called when View gets created.
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((barcode) {
      this.barcode = barcode;
      if (barcode.code == qr_value) {
        controller.stopCamera();
        make_attendence();
        id.text = "";
        // Get.off(() => const LoginScreen());
        //ShowToast("Attendenced Sucessed");
      } else {
        controller.stopCamera();
        Get.offAll(() => const Home());
        print("error////////////////////////////////////////////////////");
        print("error//////////////////////////////////////////////////////");

        print("error/////////////////////////////////////////////////////");
        ShowToast("wrong_qr".tr);
      }
    });
    update();
  }

  ///
  ///
  Locale? locale;
  changeLang(String code) {
    locale = Locale(code);
    Get.updateLocale(locale!);
    update();
    Get.to(() => const LoginScreen());
  }

  DeviceType getdevicetype(MediaQueryData mediaQueryData) {
    Orientation orientation = mediaQueryData.orientation;
    double width = 0;
    double hight = 0;
    if (orientation == Orientation.landscape) {
      width = mediaQueryData.size.height;
      hight = mediaQueryData.size.width;
    } else {
      width = mediaQueryData.size.width;
      hight = mediaQueryData.size.height;
    }
    if (width >= 950) {
      return DeviceType.Desktop;
    }
    if (width >= 600) {
      return DeviceType.Tablet;
    }
    //update();
    return DeviceType.Mobile;
  }

  /////
  showLoading(hight,width) {
    return Center(
        child: Container(
            padding: EdgeInsets.all(30.sp),
            height:hight,
            width: width,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 222, 209, 226),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "loading".tr,
                  style: TextStyle(fontSize: 15.sp),
                ),
                const CircularProgressIndicator(
                  strokeWidth: 2,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                ),
              ],
            )));
  }
  
}

enum DeviceType { Mobile, Tablet, Desktop }

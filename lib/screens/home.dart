import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project_student/controller/app_controller.dart';
import 'package:graduation_project_student/screens/qr_view.dart';
import 'package:graduation_project_student/widget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  showDialogBox() => showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text("no_connection".tr),
            content: Text("check_internet".tr),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, 'cancel');
                    setState(() => isAlertSet = false);
                    isDeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isDeviceConnected) {
                      showDialogBox();
                      setState(() => isAlertSet = true);
                    }
                  },
                  child: Text("ok".tr))
            ],
          ));
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      showDialogBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 8.h),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0xFF345696),
            Color(0xFFD18B8B),
            Color(0xFF345696),
          ])),
      child: GetBuilder<Login_Controller>(
        init: Login_Controller(),
        builder: (controller) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.h),
              height: 70.h,
              width: 100.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 233, 224, 236)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleImage(controller.imageUrl, controller.visible),
                  CustomText("id".tr, controller.id_, controller.visible),
                  CustomText(
                      "name".tr,
                      "${controller.first_name} ${controller.second_name} ${controller.third_name} ${controller.last_name}",
                      controller.visible),
                  CustomText("specialization".tr, controller.specialization,
                      controller.visible),
                  CustomText("year".tr, controller.year, controller.visible),
                  CustomText(
                      "index".tr, controller.index_no, controller.visible),
                ],
              ),
            ),

            InkWell(
              onTap: () {
                //controller.scan_qr();
                Get.to(const QR_View());
              },
              child: Container(
                //margin: const EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                height: 10.h,
                width: 65.w,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "scan_button".tr,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Icon(
                      Icons.qr_code,
                      size: 12.sp,
                    )
                  ],
                ),
              ),
            ),
            //const SizedBox(height: 20),
          ],
        ),
      ),
    ));
  }
}

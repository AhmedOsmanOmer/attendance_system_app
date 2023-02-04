import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project_student/controller/app_controller.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ////
  ///connection check
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  getConectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen((event) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      });

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
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  ////
  ///
  ///
  Login_Controller lc = Login_Controller();
  bool isloading = false;
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
  void initState()  {
    getConectivity();
    super.initState();
    lc.get_imei_mac();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<Login_Controller>(
          init: Login_Controller(),
          builder: (controller) =>
              LayoutBuilder(builder: (context, constraints) {
            return Container(
                height: constraints.maxHeight, //100.h,
                width: constraints.maxWidth, //100.w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color(0xFF345696),
                      Color(0xFFD18B8B),
                      Color(0xFF345696),
                    ])),
                child: isloading == true
                    ? controller.showLoading(constraints.maxHeight * 0.3,
                        constraints.maxHeight * 0.3)
                    : Stack(clipBehavior: Clip.none, children: [
                        Positioned(
                            top: constraints.maxHeight * 0.13, //26.h,
                            left: constraints.maxWidth * 0.32,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 40.sp, color: Colors.white),
                            )),
                        //
                        //
                        //login Button
                        Positioned(
                            top: constraints.maxHeight * 0.642,
                            left: constraints.maxWidth * 0.2, //20.w,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  isloading = true;
                                });
                                await controller.login(controller.id, context);

                                setState(() {
                                  isloading = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 225, 211, 230),
                                ),
                                alignment: Alignment.center,
                                width: 60.w,
                                height: 10.h,
                                child: Text(
                                  "login_button".tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                        //

                        ////
                        //////Form ****************************************************
                        Positioned(
                          left: constraints.maxWidth * 0.05, //5.w,
                          top: constraints.maxHeight * 0.35, //75.w,
                          child: Container(
                            padding: EdgeInsets.all(
                                constraints.maxWidth * 0.03), //5.w),
                            height: 30.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 158, 135, 165)
                                            .withOpacity(0.9),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                                color:
                                    const Color.fromARGB(255, 222, 209, 226)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 6.h,
                                  width: 12.w,
                                  color: const Color.fromARGB(255, 0, 38, 77),
                                  child: Icon(Icons.person,
                                      color: Colors.white, size: 4.h),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 6.h,
                                    width: 12.w,
                                    color:
                                        const Color.fromARGB(255, 57, 81, 120),
                                    child: TextFormField(
                                      controller: controller.id,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.sp),
                                      decoration: InputDecoration(
                                        hintStyle: const TextStyle(
                                            color: Colors.white),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.fromLTRB(
                                          3.w,
                                          0,
                                          3.w,
                                          2.w,
                                        ),
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 57, 81, 120),
                                        hintText: "login_hint".tr,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// Form End *****************************************
                        ///
                        ///
                        /// Avatar
                        Positioned(
                            top: constraints.maxHeight * 0.25, //26.h,
                            left: constraints.maxWidth * 0.33, // 34.w,
                            child: CircleAvatar(
                                maxRadius: 50.sp,
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 38, 77),
                                child: Icon(
                                  Icons.person_outline,
                                  size: 60.sp,
                                  color: Colors.white,
                                ))),
                      ]));
          }),
        ));
  }
}

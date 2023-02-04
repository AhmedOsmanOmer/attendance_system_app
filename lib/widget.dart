// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

ShowToast(String msg) {
  return Fluttertoast.showToast(
      webPosition: "center",
      webBgColor: "linear-gradient(to right, #0xFFC7BACB, #0xFFC7BACB)",
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: const Color.fromARGB(255, 232, 208, 236),
      textColor: Colors.black,
      fontSize: 20.0);
}

ContainerButton(String text, Color color) {
  return Container(
    alignment: Alignment.center,
    height: 7.h,
    width: 40.w,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(50)),
    child: Text(
      text,
      style: TextStyle(fontSize: 12.sp),
    ),
  );
}

CustomText(String lb, String data, bool visible) {
  return Visibility(
    visible: visible,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            alignment: Alignment.center,
            height: 4.h,
            width: 22.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white70.withOpacity(0.5)),
            child: Text(lb,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: const Color(0xFF345696)))),
        Container(
            alignment: Alignment.center,
            height: 4.h,
            width: 62.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white70.withOpacity(0.5)),
            child: Text(data,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: const Color(0xFF345696)))),
      ],
    ),
  );
}

CircleImage(url, bool visible) {
  return Visibility(
    visible: visible,
    child: Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        width: 60.w,
        height: 20.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.fill),
        ),
        //  child: Image.network(url),
      ),
    ),
  );
}

showAlertDialog(BuildContext context, String title, String message) =>
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("ok".tr))
                ]));

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project_student/controller/app_controller.dart';
import 'package:graduation_project_student/widget.dart';
import 'package:sizer/sizer.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:LayoutBuilder(builder: (context, constraints) {
        return 
        Container(
            height: constraints.maxHeight,//100.h,
            width: constraints.maxWidth,//100.w,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFF345696),
                  Color(0xFFD18B8B),
                  Color(0xFF345696),
                ])),
            child: Center(
                child: GetBuilder<Login_Controller>(
                    init: Login_Controller(),
                    builder: ((controller) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Please Select Language",
                                style: TextStyle(fontSize: 18.sp)),
                            SizedBox(height: 5.h),
                            Text("الرجاء اختيار اللغة",
                                style: TextStyle(fontSize: 18.sp)),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {
                                      controller.changeLang("en");
                                    },
                                    child: ContainerButton(
                                        "English", const Color(0xFFC7BACB))),
                                SizedBox(width: 10.w),
                                InkWell(
                                    onTap: () {
                                      controller.changeLang("ar");
                                    },
                                    child: ContainerButton(
                                        "العربية", const Color(0xFFC7BACB))),
                              ],
                            ),
                          ],
                        )
                        )
                        )
                        )
                        );
  }));
  }
}

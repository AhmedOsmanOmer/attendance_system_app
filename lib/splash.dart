import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_student/start.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: MediaQuery.of(context).size.width + 100,
      //centered: false,
      splash: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: constraints.maxHeight * 0.000001,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.7,
                  child: Lottie.asset(
                    "assets/1-qr-code.json",
                  )),
              Positioned(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                top: constraints.maxHeight * 0.7,
                child: AnimatedTextKit(
                  onTap: (){},
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'It Is Attendance Time',
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 161, 123, 177),
                        fontFamily: "Domine",
                        fontSize: 33.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: false,
                ),
              ),
            ],
          );
        }),
      ),
      nextScreen: const Start(),
      duration: 5000,
    );
  }
}

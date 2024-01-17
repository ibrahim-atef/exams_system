import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
 import 'package:spring/spring.dart';

import '../../../utilites/my_strings.dart';
import '../../routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetStorage savedData = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), () {

            Get.offNamed(Routes.loginScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Spring.slide(
          child: Column(
   mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/undraw_selection_re_ycpo.png"),
              Text("Take your exam online ")
            ],
          ),
          slideType: SlideType.slide_in_left,
          delay: Duration(milliseconds: 1100),
          animDuration: Duration(milliseconds: 1200),
          curve: Curves.bounceOut,
          extend: 30,
          withFade: true,
        ),
      ),
    );
  }
}

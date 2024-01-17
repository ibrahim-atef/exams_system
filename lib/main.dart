import 'package:exam/routes/routes.dart';
import 'package:exam/utilites/my_strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GetStorage savedData = GetStorage();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exams',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      getPages: Routes.routes,
      initialRoute: savedData.read("role") == null
          ? Routes.splashScreen
          :savedData.read("role") ==adminRole?Routes.adminHomeScreen: Routes.homeScreen,
//home:  SplashScreen(),
    );
  }
} //

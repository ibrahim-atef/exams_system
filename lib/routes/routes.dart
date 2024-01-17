import 'package:exam/view/screens/admin_screens/admin_home_screen.dart';
import 'package:exam/view/screens/admin_screens/exam_details_screen.dart';
import 'package:get/get.dart';

import '../controller/bindings/admin_q_binding.dart';
import '../controller/bindings/auth_binding.dart';
import '../controller/bindings/question_binding.dart';
import '../controller/bindings/student_home_binding.dart';
import '../view/screens/admin_screens/adding_exam_screen.dart';
import '../view/screens/auth_screens/login_screen.dart';
import '../view/screens/auth_screens/sign_up_screen.dart';
import '../view/screens/students_screens/exasms_screen.dart';
import '../view/screens/students_screens/question_screen.dart';
import '../view/screens/students_screens/student_home_screen.dart';
import '../view/screens/splash_screen.dart';

/// clean hhh

class Routes {
  static const splashScreen = "/splashScreen";
  static const signUpScreen = "/signUpScreen";
  static const loginScreen = "/loginScreen";
  static const homeScreen = "/homeScreen";
  static const adminHomeScreen = "/adminHomeScreen";
  static const addingExamScreen = "/addingExamScreen";
  static const questionScreen = "/questionScreen";
  static const examDetailsScreen = "/examDetailsScreen";
  static const studentExamsScreen = "/studentExamsScreen";
  static const studentQuestionScreen = "/studentQuestionScreen";

  static final routes = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
        name: loginScreen,
        page: () => LoginScreen(),
        transition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 700),
        binding: AuthBinding()),
    GetPage(
        name: signUpScreen,
        page: () => SignUpScreen(),
        transition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 700),
        bindings: [
          AuthBinding(),
        ]),
    GetPage(
        name: homeScreen,
        page: () => HomeScreen(),
        binding: AuthBinding(),
        transition: Transition.rightToLeft,
        bindings: [StudentHomeBinding()]),
    GetPage(
        name: adminHomeScreen,
        page: () => AdminHomeScreen(),
        transition: Transition.rightToLeft,
        bindings: [AuthBinding(), AdminQuizBinding(),QuestionBinding(), StudentHomeBinding()]),
    GetPage(
      name: addingExamScreen,
      page: () => AddingExamScreen(),
      transition: Transition.rightToLeft,
      bindings: [AuthBinding(), AdminQuizBinding()],
    ),
    GetPage(
      name: examDetailsScreen,
      page: () => ExamDetailsScreen(),
      transition: Transition.rightToLeft,
      bindings: [AuthBinding(), AdminQuizBinding()],
    ),
    GetPage(
      name: studentExamsScreen,
      page: () => StudentExamsScreen(),
      transition: Transition.rightToLeft,
      bindings: [AuthBinding(), AdminQuizBinding(), StudentHomeBinding()],
    ),  GetPage(
      name: studentQuestionScreen,
      page: () => StudentQuestionScreen(),
      transition: Transition.rightToLeft,
      bindings: [AuthBinding(), AdminQuizBinding(), StudentHomeBinding(),QuestionBinding()],
    ),
  ];
}

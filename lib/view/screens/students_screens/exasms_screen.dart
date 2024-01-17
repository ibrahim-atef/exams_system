import 'package:exam/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

 import '../../../controller/controllers/student_main_controller.dart';
import '../../../utilites/themes.dart';
import '../../widgets/reusable_widget/text_utils.dart';
import '../admin_screens/admin_home_screen.dart';

class StudentExamsScreen extends StatelessWidget {
  StudentExamsScreen({super.key});

  final studentHomeController = Get.find<StudentHomeController>();
  UserModel userModel = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Exams"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetX<StudentHomeController>(
          initState: (f) {

            userModel.uid != ""?f.controller!.getAdminExamsById(userModel.uid!):null;

          },
          builder: (_) {
            if (studentHomeController.isGettingExams.value) {
              return Center(
                  child: SizedBox(
                      width: Get.width * .6,
                      height: 2,
                      child: LinearProgressIndicator(
                        color: MAINCOLOR,
                      )));
            } else if (studentHomeController.adminExams.value.isEmpty) {
              return Center(
                child: KTextWidget(
                  text: "there is no exams ",
                  size: 14,
                  color: MAINCOLOR,
                  fontWeight: FontWeight.w500,
                ),
              );
            } else {
              return examListWidget(studentHomeController.adminExams.value,userModel);
            }
          },
        ),
      ),
    );
  }
}

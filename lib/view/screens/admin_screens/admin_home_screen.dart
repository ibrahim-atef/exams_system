import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam/controller/controllers/admin_q_controller.dart';
import 'package:exam/model/user_model.dart';
import 'package:exam/routes/routes.dart';
import 'package:exam/utilites/my_strings.dart';
import 'package:exam/utilites/themes.dart';
import 'package:exam/view/widgets/reusable_widget/main_Button_widget.dart';
import 'package:exam/view/widgets/reusable_widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/auth_controller.dart';
import '../../../controller/controllers/question_controller.dart';
import '../../../controller/controllers/student_main_controller.dart';
import '../../../model/exam_model.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({Key? key});

  final authController = Get.find<AuthController>();
  final adminQuizController = Get.find<AdminQuizController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GetBuilder<AuthController>(
            builder: (_) {
              return InkWell(
                onTap: () {
                  authController.signOutFromApp();
                },
                child: Icon(Icons.logout),
              );
            },
          )
        ],
        title: GetX<AuthController>(
          builder: (_) {
            return KTextWidget(
                text:
                    "hello ${authController.myData.value != null ? authController.myData.value!.name : ''}",
                size: 18,
                color: MAINCOLOR,
                fontWeight: FontWeight.w500);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetX<AdminQuizController>(
          builder: (_) {
            if (adminQuizController.isGettingExams.value) {
              return Center(
                  child: SizedBox(
                      width: Get.width * .6,
                      height: 2,
                      child: LinearProgressIndicator(
                        color: MAINCOLOR,
                      )));
            } else if (adminQuizController.adminExams.isEmpty) {
              return Center(
                child: KTextWidget(
                  text: "you have no exams ",
                  size: 14,
                  color: MAINCOLOR,
                  fontWeight: FontWeight.w500,
                ),
              );
            } else {
              return adminQuizController.adminExams.isEmpty ||authController.myData.value ==null
                  ? Center(child: CircularProgressIndicator())
                  : examListWidget(
                  adminQuizController.adminExams, authController.myData.value!);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.addingExamScreen);
        },
        child: Icon(
          Icons.add,
          color: WHITE,
        ),
        backgroundColor: MAINCOLOR,
      ),
    );
  }
}

Widget examListWidget(List exams, UserModel admin) {
  return  ListView.builder(
          itemCount: exams.length,
          itemBuilder: (context, index) {
            var exam = exams[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: GetBuilder(
                builder: (StudentHomeController studentHomeController) {
                  return ListTile(
                    title: KTextWidget(
                      text: exam.title,
                      size: 16,
                      fontWeight: FontWeight.w800,
                      color: MAINCOLOR,
                    ),
                    subtitle: Column(
                      children: [
                        KTextWidget(
                          text: exam.description,
                          size: 14,
                          color: PARAGRAPH,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        studentHomeController.role == studentsCollectionKey
                            ? MainButton(
                                onPressed: () {
                                  studentHomeController.getExamQuestions(
                                      exam.id, admin.uid!, exam);
                                },
                                text: studentHomeController
                                        .isGettingQuestions.value
                                    ? SizedBox(
                                        width: Get.width * .5,
                                        child: LinearProgressIndicator(
                                          color: MAINCOLOR,
                                        ),
                                      )
                                    : Text("Take Exam"),
                                width: Get.width * .8,
                                mainColor: WHITE,
                                borderColor: WHITE)
                            : SizedBox()
                      ],
                    ),
                    onTap: () {
                      studentHomeController.role == studentsCollectionKey
                          ? null
                          : Get.toNamed(Routes.examDetailsScreen,
                              arguments: [exam]);
                    },
                  );
                },
              ),
            );
          },
        );
}

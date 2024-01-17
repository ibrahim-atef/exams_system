import 'package:exam/utilites/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/admin_q_controller.dart';
import '../../../model/exam_model.dart';

class ExamQuestionsScreen extends StatelessWidget {
  ExamModel examModel;

  ExamQuestionsScreen({required this.examModel});

  final adminQuizController = Get.find<AdminQuizController>();

  @override
  Widget build(BuildContext context) {
    return GetX<AdminQuizController>(initState: (s) {
      s.controller!.getExamQuestionsByExamId(examModel.id);
    }, builder: (_) {
      return adminQuizController.isGettingQuestions.value
          ? CircularProgressIndicator(
              color: MAINCOLOR,
            )
          : adminQuizController.adminQuestions.isEmpty
              ? const Center(
                  child: Text("u didn't add any questions here"),
                )
              : ListView.builder(
                  itemCount: adminQuizController.adminQuestions.value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(adminQuizController
                          .adminQuestions.value[index].question),
                    );
                  },
                );
    });
  }
}

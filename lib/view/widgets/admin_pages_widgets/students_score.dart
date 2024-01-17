import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/admin_q_controller.dart';
import '../../../model/exam_model.dart';
import '../../../utilites/themes.dart';

class StudentsOrderedByScoresScreen extends StatelessWidget {
  ExamModel examModel;

  StudentsOrderedByScoresScreen({required this.examModel});

  final adminQuizController = Get.find<AdminQuizController>();

  @override
  Widget build(BuildContext context) {

    return GetX<AdminQuizController>(
      initState: (s) {
        s.controller!.getStudentsScoreList(examModel.id);
      },
      builder: (_) {
        return adminQuizController.isGettingQuestions.value
            ? CircularProgressIndicator(
                color: MAINCOLOR,
              )
            : adminQuizController.studentsScoreList.value.isEmpty
                ? const Center(
                    child: Text("u didn't add any students here"),
                  )
                : ListView.builder(
                    itemCount:
                        adminQuizController.studentsScoreList.value.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(adminQuizController
                                .studentsScoreList.value[index].studentName),
                            Text("--"),
                            Text(adminQuizController
                                .studentsScoreList.value[index].score
                                .toString()),
                          ],
                        ),
                      );
                    },
                  );
      },
    );
  }
}

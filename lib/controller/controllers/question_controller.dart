import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import 'package:timer_count_down/timer_controller.dart';

import '../../utilites/my_strings.dart';
import '../../view/widgets/reusable_widget/show_snack.dart';

class QuestionController extends GetxController {
  final CountdownController countdownController =
      new CountdownController(autoStart: true);
  String groupValue = "";
  int currentIndex = 0;
  RxBool isSubmittingExam = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  List<String> answersList = [];
  List<String> correctAnswersList = [];
  List<int> answerScores = [];

  ///hhhhhh
  GetStorage savedData = GetStorage();

  updateCorrectAnswersList(List<String> l) {
    correctAnswersList = l;
    update();
  }

  updateAnswerScoresList(List<int> s) {
    answerScores = s;
    update();
  }

  updateLists(int questionListLength) {
    answersList = List.generate(questionListLength, (index) => "");
    print(answersList);
    update();
  }

  updateAnswer(
    int index,
    String answer,
    String realAnswer,
  ) {
    answersList.replaceRange(index, index + 1, [answer]);

    // realAnswerList.replaceRange(index, index + 1, [realAnswer]);
    update();
  }

  changeCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  changeGroupValue(value) {
    groupValue = value;

    print(answersList);
    update();
  }

  String formatHHMMSS(int seconds) {
    if (seconds != null && seconds != 0) {
      int hours = (seconds / 3600).truncate();
      seconds = (seconds % 3600).truncate();
      int minutes = (seconds / 60).truncate();

      String hoursStr = (hours).toString().padLeft(2, '0');
      String minutesStr = (minutes).toString().padLeft(2, '0');
      String secondsStr = (seconds % 60).toString().padLeft(2, '0');

      if (hours == 0) {
        return "$minutesStr:$secondsStr";
      }
      return "$hoursStr:$minutesStr:$secondsStr";
    } else {
      return "0:0";
    }
  }

  int totalStudentScore = 0;
  int totalExamScore = 0;

  void calculateScore() {
    for (int i = 0; i < answersList.length; i++) {
      if (answersList[i] == correctAnswersList[i]) {
        totalStudentScore += answerScores[i];
      }
    }
    update();
  }
    calculateSum(List<int> numbers) {
    totalExamScore= numbers.reduce((value, element) => value + element);
    update();
  }
  Future submitExam(
      String examID, String adminId, UserModel myData,) async {
    isSubmittingExam.value = true;
       calculateScore();
    await _firestore
        .collection(
            adminCollectionKey) // Replace 'admin' with your admin collection name
        .doc(adminId)
        .collection('exams')
        .doc(examID)
        .collection(studentsCollectionKey)
        .doc(myData.uid)
        .set({
      "studentName": myData.name,
      "score": totalStudentScore,
    }).then((value) { isSubmittingExam.value = false;
    calculateSum(answerScores);
      Get.defaultDialog(
        title: "Exam Finished",
        middleText: "Thanks for finishing the exam!\nYour score is $totalStudentScore/$totalExamScore",
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ).then((value) {
        currentIndex=0;
      update();
        Get.back();}
      );
    }).catchError((e) {isSubmittingExam.value = false;
      showSnackbar("Error", e.toString(), Colors.red);
    });
    print(answersList);

    update();

    update();
  }
}

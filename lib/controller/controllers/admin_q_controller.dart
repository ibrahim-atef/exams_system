import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam/utilites/themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/exam_model.dart';
import '../../model/questions_model.dart';
import '../../model/user_model.dart';
import '../../utilites/my_strings.dart';
import '../../view/widgets/reusable_widget/show_snack.dart';

class AdminQuizController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage authBox = GetStorage();
  RxBool isExamUploading = false.obs;
  RxBool isGettingExams = false.obs;
  RxBool isGettingQuestions = false.obs;
  RxBool isGettingStudentsScoreList = false.obs;
  RxBool isAddingQuestion = false.obs;
  String uid = "";

  @override
  void onInit() async {
    uid = await authBox.read(KUid);
    super.onInit();
    // Fetch exams when the controller is initialized
    uid.isNotEmpty
        ? getAdminExamsById(uid)
        : null; // Replace 'adminId' with the actual admin ID
  }

  // Function to get the exams by admin id
  RxList adminExams = [].obs;  RxList studentsScoreList = [].obs;

  RxList adminQuestions = [].obs;

  Future<void> getAdminExamsById(String adminId) async {
    try {
      isGettingExams.value = true;
      adminExams.clear();

      _firestore
          .collection(
              'admin') // Replace 'admin' with your admin collection name
          .doc(adminId)
          .collection('exams')
          .snapshots()
          .listen((event) {
        adminExams.clear();

        for (int i = 0; i < event.docs.length; i++) {print("fffffffffffffffffffff");

          adminExams.add(
              ExamModel.fromMap(event.docs[i], event.docs[i].id.toString()));
        }
      });
      update();
      isGettingExams.value = false;
    } catch (e) {
      isGettingExams.value = false;
      await showSnackbar("Error", e.toString(), Colors.red);
    }
  }

  //get the questions in the exam
  Future<void> getExamQuestionsByExamId(String examId) async {
    try {
      isGettingQuestions.value = true; // Set to true while fetching questions
      adminQuestions.clear(); // Clear the existing questions list

        _firestore
          .collection(
            adminCollectionKey) // Replace 'admin' with your admin collection name
          .doc(uid)
          .collection('exams')
          .doc(examId)
          .collection(questionCollectionKey)
          .snapshots()
          .listen((event) {
        adminQuestions.clear();

        for (int i = 0; i < event.docs.length; i++) {
          adminQuestions.add(QuestionDataModel.fromJson(event.docs[i]));
        }
      });isGettingQuestions.value = false;

      // Now you have the list of questions related to the examId
      // You can store it in a variable or use it as needed

      print('Questions List: $adminQuestions');
    } catch (e) {isGettingQuestions.value = false;
    // Handle any errors that may occur during the process
      print('Error getting questions: $e');
    } finally {
      isGettingQuestions.value = false; // Set to false after fetching questions

    }
  }


  //get the student's score list
  Future<void> getStudentsScoreList(String examId) async {
    try {
      isGettingStudentsScoreList.value = true; // Set to true while fetching questions
      studentsScoreList.clear(); // Clear the existing questions list

        _firestore
          .collection(
              adminCollectionKey) // Replace 'admin' with your admin collection name
          .doc(uid)
          .collection('exams')
          .doc(examId)
          .collection(studentsCollectionKey)
          .snapshots()
          .listen((event) {
          studentsScoreList.clear();

        for (int i = 0; i < event.docs.length; i++) {
          studentsScoreList.add(StudentScoreModel.fromJson(event.docs[i]));
        }
          studentsScoreList.sort((a, b) => b.score.compareTo(a.score));
      });

      // Now you have the list of questions related to the examId
      // You can store it in a variable or use it as needed

      print('Questions List: $studentsScoreList');
    } catch (e) {
      // Handle any errors that may occur during the process
      print('Error getting questions: $e');
    } finally {
      isGettingStudentsScoreList.value = false;
    }
  }

  // Function to add an exam
  Future<void> addExam({
    required String title,
    required String description,
    required int duration,
  }) async {
    isExamUploading.value = true;
    String myId = await authBox.read(KUid);
    String myRole = await authBox.read('role');
    try {
      if (myRole.isNotEmpty && myId.isNotEmpty) {
        await _firestore.collection(myRole).doc(myId).collection('exams').add({
          'title': title,
          'description': description,
          'duration': duration,
          // Add any other exam-related fields as needed
        }).then((value) async {
          isExamUploading.value = false;
          Get.back();
          await showSnackbar(
              "Success", "Exam details added successfully", MAINCOLOR);

          update();
        });
      }
    } catch (e) {
      isExamUploading.value = true;
      await showSnackbar("Error", e.toString(), Colors.red);
      print('Error adding exam: $e');
      update();
    }
  }

  // add the question to the specific exam by id

  Future<void> addQuestion({
    required String question,
    required int questionMark,
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
    required String correctAnswer,
    required String examId,
  }) async {
    isAddingQuestion.value = true;
    String myId = await authBox.read(KUid);
    String myRole = await authBox.read('role');
    try {
      if (myRole.isNotEmpty && myId.isNotEmpty) {
        await _firestore
            .collection(myRole)
            .doc(myId)
            .collection('exams')
            .doc(examId)
            .collection(questionCollectionKey)
            .add(QuestionDataModel(
              question: question,
              questionMark: questionMark,
              answer1: answer1,
              answer2: answer2,
              answer3: answer3,
              answer4: answer4,
              correctAnswer: correctAnswer,
            ).toJson())
            .then((value) {
          isAddingQuestion.value = false;
          Get.back();
          showSnackbar("Success", "Question added successfully", MAINCOLOR);

          update();
        });
      }
    } catch (e) {
      isAddingQuestion.value = false;
      showSnackbar("Error", e.toString(), Colors.red);
      print('Error adding question: $e');
      update();
    }
  }

  // Navigate to the screen to add an exam
  void navigateToAddExamScreen() {
    // Add your navigation logic here
    // For example, you can use Get.toNamed() or Get.offNamed() to navigate to the add exam screen
    // Get.toNamed('/add_exam_screen');
  }

  // Navigate to the screen to add a question for a specific exam
  void navigateToAddQuestionScreen(String examId) {
    // Add your navigation logic here
    // For example, you can use Get.toNamed() or Get.offNamed() to navigate to the add question screen
    // Get.toNamed('/add_question_screen', arguments: examId);
  }
}

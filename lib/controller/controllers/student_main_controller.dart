import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam/controller/controllers/question_controller.dart';
import 'package:exam/model/questions_model.dart';
import 'package:exam/utilites/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/exam_model.dart';
import '../../model/user_model.dart';
import '../../routes/routes.dart';
import '../../utilites/my_strings.dart';
import '../../view/widgets/reusable_widget/show_snack.dart';

class StudentHomeController extends GetxController {
  RxBool isGettingAdmins = false.obs;
  RxList adminsList = [].obs;
  RxBool isGettingExams = false.obs;
  final GetStorage authBox = GetStorage();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList adminExams = [].obs;
  String role = "";

  @override
  void onInit() async {
    getAdmins();
    role = await authBox.read("role");
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> getAdmins() async {
    try {
      isGettingAdmins.value = true;
      adminsList.clear();

      _firestore
          .collection(
              adminRole) // Replace 'admins' with your admin collection name
          .snapshots()
          .listen((event) {
        adminsList.clear();

        for (int i = 0; i < event.docs.length; i++) {
          adminsList.add(UserModel.fromMap(event.docs[i]));
        }
      });

      isGettingAdmins.value = false;
    } catch (e) {
      isGettingAdmins.value = false;
      await showSnackbar("Error", e.toString(), Colors.red);
    }
  }

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

        for (int i = 0; i < event.docs.length; i++) {
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

  RxList questionDataModel = [].obs;
  RxBool isGettingQuestions = false.obs;
  final questionController = Get.put(QuestionController());

  /// function to get the questions list
  Future<void> getExamQuestions(
      String examID, String adminId, ExamModel examModel) async {
    print("examID :$examID");
    print("adminId :$adminId");
    try {
      questionDataModel.clear();
      isGettingQuestions.value = true;
      List<String> l=[];
      List<int> s=[];
      await _firestore
          .collection(
              adminCollectionKey) // Replace 'admin' with your admin collection name
          .doc(adminId)
          .collection('exams')
          .doc(examID)
          .collection(questionCollectionKey)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          questionDataModel.clear();
          for (int i = 0; i < value.docs.length; i++) {
            questionDataModel.add(QuestionDataModel.fromJson(value.docs[i]));
            l.add(questionDataModel[i].correctAnswer);
            s.add(questionDataModel[i].questionMark);

          }
          isGettingQuestions.value = false;
          questionController.updateLists(questionDataModel.length);
          questionController.updateCorrectAnswersList(l);
          questionController.updateAnswerScoresList(s);

          ///go questions screen
          Get.toNamed(Routes.studentQuestionScreen,
              arguments: [questionDataModel, examModel,adminId]);
          update();
        } else {
          isGettingQuestions.value = false;
          showSnackbar("sorry", "there's no questions in this exam", MAINCOLOR);
          questionDataModel.clear();
          print("You don't have Questions");
        }
      });
      update();

      isGettingQuestions.value = false;
    } catch (e) {
      isGettingQuestions.value = false;
      await showSnackbar("Error", e.toString(), Colors.red);
    }
  }
}

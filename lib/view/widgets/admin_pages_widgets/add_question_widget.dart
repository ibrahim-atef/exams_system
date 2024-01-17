import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/admin_q_controller.dart';
import '../../../utilites/themes.dart';
import '../auth_widgets/auth_text_from_field.dart';
import '../reusable_widget/text_utils.dart';

class AddQuestionWidget extends StatelessWidget {
  TextEditingController questionController = TextEditingController();
  TextEditingController answer1Controller = TextEditingController();
  TextEditingController answer2Controller = TextEditingController();
  TextEditingController answer3Controller = TextEditingController();
  TextEditingController answer4Controller = TextEditingController();
  TextEditingController correctAnswerController = TextEditingController();
  TextEditingController questionMarkController = TextEditingController();
  String examId;
  final adminQuizController = Get.find<AdminQuizController>();

  AddQuestionWidget({required this.examId});

  @override
  Widget build(BuildContext context) {
    return  GetX<AdminQuizController>(builder: (_) {return Container(
      height: Get.height * .5,
      width: Get.width * .9,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KTextWidget(
              text: "Add Question",
              size: 20,
              color: PARAGRAPH,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20),
            AuthTextFromField(
              inputColor: PARAGRAPH.withOpacity(.7),
              controller: questionController,
              obscureText: false,
              validator: (c) {
                return null;
              },
              hintText: "Question",
              textInputType: TextInputType.text,
              suffixIcon: null,
            ),
            SizedBox(height: 20),
            AuthTextFromField(
              suffixIcon: null,
              inputColor: PARAGRAPH.withOpacity(.7),
              controller: answer1Controller,
              obscureText: false,
              validator: (c) {
                return null;
              },
              hintText: "Answer 1",
              textInputType: TextInputType.text,
            ),
            SizedBox(height: 20),
            AuthTextFromField(
              suffixIcon: null,
              inputColor: PARAGRAPH.withOpacity(.7),
              controller: answer2Controller,
              obscureText: false,
              validator: (c) {
                return null;
              },
              hintText: "Answer 2",
              textInputType: TextInputType.text,
            ),
            SizedBox(height: 20),
            AuthTextFromField(
              suffixIcon: null,
              inputColor: PARAGRAPH.withOpacity(.7),
              controller: answer3Controller,
              obscureText: false,
              validator: (c) {
                return null;
              },
              hintText: "Answer 3",
              textInputType: TextInputType.text,
            ),
            SizedBox(height: 20),
            AuthTextFromField(
              suffixIcon: null,
              inputColor: PARAGRAPH.withOpacity(.7),
              controller: answer4Controller,
              obscureText: false,
              validator: (c) {
                return null;
              },
              hintText: "Answer 4",
              textInputType: TextInputType.text,
            ),
            SizedBox(height: 20),
            AuthTextFromField(
              suffixIcon: null,
              inputColor: PARAGRAPH.withOpacity(.7),
              controller: correctAnswerController,
              obscureText: false,
              validator: (c) {
                return null;
              },
              hintText: "Correct Answer",
              textInputType: TextInputType.text,
            ),
            SizedBox(height: 20),
            AuthTextFromField(
              suffixIcon: null,
              inputColor: PARAGRAPH.withOpacity(.7),
              controller: questionMarkController,
              obscureText: false,
              validator: (c) {
                return null;
              },
              hintText: "Question Mark",
              textInputType: TextInputType.number
              ,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
          adminQuizController.isAddingQuestion.value?Center(
              child: SizedBox(
                  width: Get.width * .6,
                  height: 2,
                  child: LinearProgressIndicator(
                    color: MAINCOLOR,
                  ))):      ElevatedButton(
                  onPressed: () async {
                    // Validate and add question
                    await validateAndAddQuestion();
                  },
                  child: Text("Add Question"),
                ),
              ],
            ),
          ],
        ),
      ),
    );  },);
  }

  Future<void> validateAndAddQuestion() async {
    // Check if all fields are filled
    if (questionController.text.isEmpty ||
        answer1Controller.text.isEmpty ||
        answer2Controller.text.isEmpty ||
        answer3Controller.text.isEmpty ||
        answer4Controller.text.isEmpty ||
        correctAnswerController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "All fields must be filled",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(.5),
      );
      return;
    }

    // Check if the question is written in the correct way (customize as needed)
    // Example: Ensure the question ends with a question mark
    if (!questionController.text.endsWith("?")) {
      Get.snackbar(
        "Error",
        "Question should end with a question mark",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(.5),
      );
      return;
    }

    // If validation succeeds, call the addQuestion function
    await adminQuizController.addQuestion(
      question: questionController.text,
      questionMark: int.parse(questionMarkController.text),
      answer1: answer1Controller.text,
      answer2: answer2Controller.text,
      answer3: answer3Controller.text,
      answer4: answer4Controller.text,
      correctAnswer: correctAnswerController.text,
      examId: examId,
    );
  }
}

import 'package:exam/view/widgets/reusable_widget/number_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/admin_q_controller.dart';
import '../../../controller/controllers/auth_controller.dart';
import '../../../utilites/themes.dart';
import '../../widgets/reusable_widget/show_snack.dart';

class AddingExamScreen extends StatelessWidget {
  TextEditingController addExamTextController = TextEditingController();
  TextEditingController addExamTitleTextController = TextEditingController();
  final adminQuizController = Get.find<AdminQuizController>();
  final authController = Get.find<AuthController>();
  int duration = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 3,
        actions: [
          GetBuilder(
            builder: (AdminQuizController adminQuizController) {
              return TextButton(
                  onPressed: () {
                    if (addExamTitleTextController.text.isEmpty) {
                      showSnackbar("Error", "Enter the Exam title", Colors.red);
                    } else if (addExamTextController.text.isEmpty) {
                      showSnackbar("Error", "Enter the Exam body", Colors.red);
                    } else {
                      adminQuizController.addExam(
                          title: addExamTitleTextController.text,
                          description: addExamTextController.text,
                          duration: duration);
                    }
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ));
            },
          )
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Create Exam",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 1,
          ),
          GetX<AdminQuizController>(
            builder: (_) {
              return adminQuizController.isExamUploading.value
                  ? LinearProgressIndicator(
                color: MAINCOLOR,
              )
                  : SizedBox();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),

                    Container(
                        height: Get.height * .06,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: TextField(
                          controller: addExamTitleTextController,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                          decoration: InputDecoration(
                            label: Text(
                              "Exam title",
                              style: TextStyle(color: Colors.black54),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Write exam title...",
                            hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          cursorRadius: Radius.circular(20),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    HorizontalNumberPicker(
                      onNumberChanged: (selectedNumber) {
                        duration = selectedNumber;
                        // You can use the selected number in your logic here
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: addExamTextController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Write new exam description...",
                            hintStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          cursorRadius: Radius.circular(20),
                        )),

                    SizedBox(
                      height: Get.height * .1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

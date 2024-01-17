import 'package:exam/controller/controllers/auth_controller.dart';
import 'package:exam/routes/routes.dart';
import 'package:exam/view/widgets/reusable_widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/student_main_controller.dart';
import '../../../model/user_model.dart';
import '../../../utilites/themes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final authController = Get.find<AuthController>();
  final studentHomeController = Get.find<
      StudentHomeController>(); // Get the instance of your StudentHomeController

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
        backgroundColor: Colors.white,
        elevation: 0,
        title: KTextWidget(
            text: "Teacher exams",
            size: 30,
            color: MAINCOLOR,
            fontWeight: FontWeight.w600),
      ),
      body: GetX<StudentHomeController>(
        builder: (_) {
          return studentHomeController.isGettingAdmins.value
              ? Center(child: CircularProgressIndicator(color: MAINCOLOR))
              : (studentHomeController.adminsList.isEmpty
                  ? Center(
                      child: KTextWidget(
                          text: "There are no teachers",
                          size: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.w100),
                    )
                  : ListView.builder(
                      itemCount: studentHomeController.adminsList.length,
                      itemBuilder: (context, index) {
                        // Access the user data using UserModel properties
                        UserModel admin =
                            studentHomeController.adminsList[index];
                        return ListTile(
                          title: KTextWidget(
                            text: admin.name ?? '',
                            // Assuming name is available in UserModel
                            size: 18,
                            color: MAINCOLOR,
                            fontWeight: FontWeight.w500,
                          ),
                          subtitle: KTextWidget(
                            text: admin.email ?? '',
                            size: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.studentExamsScreen,
                                  arguments: [admin]);
                            },
                            child: Text("Show Exams"),
                          ),
                        );
                      },
                    ));
        },
      ),
    );
  }
}

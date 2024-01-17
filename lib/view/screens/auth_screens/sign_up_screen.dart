import 'package:exam/view/widgets/auth_widgets/role_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/controllers/auth_controller.dart';
import '../../../routes/routes.dart';
import '../../../utilites/my_strings.dart';
import '../../../utilites/themes.dart';
import '../../widgets/auth_widgets/auth_text_from_field.dart';
import '../../widgets/reusable_widget/main_Button_widget.dart';
import '../../widgets/reusable_widget/text_utils.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(
        color: WHITE,
        image: DecorationImage(
            image: AssetImage(
              "assets/auth_back.jpeg",
            ),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .1),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * .08,
                  ),
                  Row(
                    children: [
                      KTextWidget(
                          text: "Hello,",
                          size: 32,
                          color: BLACK,
                          fontWeight: FontWeight.w800),
                      KTextWidget(
                          text: "Friend!",
                          size: 32,
                          color: MAINCOLOR,
                          fontWeight: FontWeight.w800),
                    ],
                  ),
                  KTextWidget(
                      text: "Sign Up",
                      size: 22,
                      color: BLACK,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    height: Get.height * .05,
                  ),

                  ///full name form field
                  AuthTextFromField(
                      controller: nameController,
                      obscureText: false,
                      validator: (value) {
                        if (value.length == 0) {
                          return 'Please enter name';
                        } else if (value.toString().length <= 2 ||
                            !RegExp(validationName).hasMatch(value)) {
                          return "Enter valid name";
                        } else {
                          return null;
                        }
                      },
                      hintText: "Full Name",
                      textInputType: TextInputType.name,
                      prefixIcon: Image.asset("assets/icons/user 1.png"),
                      suffixIcon: SizedBox()),
                  SizedBox(height: Get.height * .035),

                  ///email form field

                  AuthTextFromField(
                      controller: emailController,
                      obscureText: false,
                      validator: (value) {
                        if (value.length == 0) {
                          return 'Please enter email';
                        } else if (!RegExp(validationEmail).hasMatch(value)) {
                          return "Invalid Email";
                        } else {
                          return null;
                        }
                      },
                      hintText: "E-mail",
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Image.asset("assets/icons/envelope 1.png"),
                      suffixIcon: SizedBox()),
                  SizedBox(height: Get.height * .035),

                  ///password form field
                  GetBuilder<AuthController>(
                    builder: (_) {
                      return AuthTextFromField(
                          controller: passwordController,
                          obscureText:
                              authController.isVisibilty ? false : true,
                          validator: (value) {
                            if (value.toString().length == 0) {
                              return "Please enter Password ";
                            } else if (value.toString().length < 8) {
                              return "Password is too short";
                            } else {
                              return null;
                            }
                          },
                          hintText: "Password",
                          textInputType: TextInputType.name,
                          prefixIcon: Image.asset("assets/icons/lock 1.png"),
                          suffixIcon: IconButton(
                            onPressed: () {
                              authController.visibility();
                            },
                            icon: authController.isVisibilty
                                ? Icon(Icons.visibility_off_outlined, size: 19)
                                : Icon(
                                    Icons.visibility_outlined,
                                    size: 19,
                                  ),
                            color: DISABLED,
                          ));
                    },
                  ),
                  SizedBox(height: Get.height * .035),
                  RoleWidget(),
                  SizedBox(height: Get.height * .12),

                  GetX<AuthController>(
                    builder: (_) {
                      return Container(
                        alignment: Alignment.center,
                        child: MainButton(
                            onPressed: () async {
                              if (authController.userRole.value.isEmpty) {
                                Get.defaultDialog(
                                    title: "",
                                    middleText: 'Please choose your role',
                                    textCancel: "Ok",
                                    middleTextStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    buttonColor: MAINCOLOR,
                                    cancelTextColor: Colors.black,
                                    backgroundColor: Colors.grey.shade200);
                              } else if (formKey.currentState!.validate()) {
                                authController.signUpUsingFirebase(
                                    name: nameController.text.toString(),
                                    email: emailController.text.toString(),
                                    password:
                                        passwordController.text.toString(),
                                    role: authController.userRole.value);
                              }
                            },
                            text: authController.isLoading.value
                                ? SizedBox(
                                    width: Get.width * .07,
                                    height: Get.width * .07,
                                    child: CircularProgressIndicator(
                                      color: WHITE,
                                    ),
                                  )
                                : KTextWidget(
                                    text: "Sign Up",
                                    size: 14,
                                    color: WHITE,
                                    fontWeight: FontWeight.w700),
                            width: Get.width * .8,
                            mainColor: MAINCOLOR,
                            borderColor: MAINCOLOR),
                      );
                    },
                  ),
                  SizedBox(height: Get.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      KTextWidget(
                          text: "Already Have an Account? ?  ",
                          size: 14,
                          color: BLACK,
                          fontWeight: FontWeight.w500),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.loginScreen);
                        },
                        child: KTextWidget(
                            text: "Login",
                            size: 15,
                            color: MAINCOLOR,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:exam/view/widgets/auth_widgets/role_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/auth_controller.dart';
import '../../../routes/routes.dart';
import '../../../utilites/my_strings.dart';
import '../../../utilites/themes.dart';
import '../../widgets/auth_widgets/auth_text_from_field.dart';
import '../../widgets/reusable_widget/main_Button_widget.dart';
import '../../widgets/reusable_widget/text_utils.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
                    height: Get.height * .11,
                  ),

                  SizedBox(
                    height: Get.height * .06,
                  ),

                  Row(
                    children: [
                      KTextWidget(
                          text: "Welcome",
                          size: 32,
                          color: BLACK,
                          fontWeight: FontWeight.w800),
                      KTextWidget(
                          text: " Back!",
                          size: 32,
                          color: MAINCOLOR,
                          fontWeight: FontWeight.w800),
                    ],
                  ),
                  KTextWidget(
                      text: "Login",
                      size: 20,
                      color: BLACK,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    height: Get.height * .05,
                  ),

                  SizedBox(height: Get.height * .035),

                  ///email form field

                  AuthTextFromField(
                      controller: _emailController,
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
                      prefixIcon: null,
                      //Image.asset("assets/icons/envelope 1.png"),
                      suffixIcon: SizedBox()),

                  SizedBox(height: Get.height * .035),

                  ///password form field
                  GetBuilder<AuthController>(
                    builder: (_) {
                      return AuthTextFromField(
                          controller: _passwordController,
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
                          prefixIcon: null,
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

                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          color: MAINCOLOR),
                    ),
                  ),
                  SizedBox(height: Get.height * .035),
                  RoleWidget(),

                  SizedBox(height: Get.height * .07),
                  GetX<AuthController>(
                    builder: (_) {
                      return Container(
                        alignment: Alignment.center,
                        child: MainButton(
                            onPressed: () {
                              String email = _emailController.text.trim();
                              String password = _passwordController.text;
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
                                authController.loginUsingFirebase(
                                  email: email,
                                  password: password,
                                  role: authController.userRole.value,
                                );
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
                                    text: "Login",
                                    size: 14,
                                    color: WHITE,
                                    fontWeight: FontWeight.w700),
                            width: Get.width * .8,
                            mainColor: MAINCOLOR,
                            borderColor: MAINCOLOR),
                      );
                    },
                  ),
                  SizedBox(height: Get.height * .035),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      KTextWidget(
                          text: "Don’t Have an Account?  ",
                          size: 14,
                          color: BLACK,
                          fontWeight: FontWeight.w500),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.signUpScreen);
                        },
                        child: KTextWidget(
                            text: "Sign Up ",
                            size: 14,
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

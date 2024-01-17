import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/auth_controller.dart';
import '../../../utilites/my_strings.dart';
import '../../../utilites/themes.dart';

class RoleWidget extends StatelessWidget {
  RoleWidget({Key? key}) : super(key: key);
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GetBuilder<AuthController>(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width * .3,
              height: height * .046,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: PARAGRAPH,
                  width: 1.3,
                ),
              ),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 25,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color:PARAGRAPH,
                      ),
                      items: const [
                        DropdownMenuItem(
                          child: Text(
                            studentRole,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,color: PARAGRAPH,
                              fontSize: 16,
                            ),
                          ),
                          value: studentRole,
                        ),
                        DropdownMenuItem(
                          value: adminRole,
                          child: Text(
                            adminRole,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,color: PARAGRAPH,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        controller.userRole.value = value!;
                        // gender=value;
                        // print(gender);
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Obx(
                            (){return Text(
                              controller.userRole.value == ""
                                  ? "role"
                                  : controller.userRole.value,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                color: PARAGRAPH,),
                            );}
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

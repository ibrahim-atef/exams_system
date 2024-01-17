import 'package:get/get.dart';

import '../controllers/admin_q_controller.dart';

class AdminQuizBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>AdminQuizController() ,fenix: false);
  }
}

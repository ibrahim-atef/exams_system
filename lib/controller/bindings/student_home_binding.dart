import 'package:get/get.dart';
import '../controllers/student_main_controller.dart';

class StudentHomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>StudentHomeController() ,fenix: false);
  }
}

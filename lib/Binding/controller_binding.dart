import 'package:bike_service_app/controller/auth_controller.dart';
import 'package:bike_service_app/controller/centers_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(centersController());
    Get.put(AuthController());
  }
}

import 'package:get/get.dart';
import 'package:instagram_clone_flutter/src/controller/bottom_nav_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    //permanent : ture / 앱 종료시점까지 유지
    Get.put(BottomNavController(), permanent: true);
  }

}
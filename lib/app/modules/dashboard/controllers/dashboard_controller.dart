import 'package:get/get.dart';

class DashboardController extends GetxController {
  final count = 0.obs;
  final tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}

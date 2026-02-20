import 'package:get/get.dart';
import '../../../services/navigation_service.dart';

class OnboardingController extends GetxController {
  final _navService = Get.find<NavigationService>();

  void getStarted() {
    _navService.toLogin();
  }
}

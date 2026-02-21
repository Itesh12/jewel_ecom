import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/services/storage_service.dart';
import '../../../services/navigation_service.dart';

class DashboardController extends GetxController {
  final _authRepository = Get.put(AuthRepository());
  final _navService = Get.find<NavigationService>();
  final count = 0.obs;
  final tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      _navService.toLogin();
    } catch (e) {
      // Even if API fails, we should clear session and move to login for safety
      Get.find<StorageService>().clearAuth();
      _navService.toLogin();
    }
  }
}

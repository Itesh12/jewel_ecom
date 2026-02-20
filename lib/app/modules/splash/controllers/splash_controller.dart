import 'package:get/get.dart';
import '../../../services/navigation_service.dart';
import '../../../data/services/storage_service.dart';

class SplashController extends GetxController {
  final _navService = Get.find<NavigationService>();
  final _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Wait for progress bar animation (2s) + brief visibility buffer
    await Future.delayed(const Duration(milliseconds: 2500));

    final token = _storageService.getToken();
    if (token != null && token.isNotEmpty) {
      _navService.toDashboard();
    } else {
      _navService.toOnboarding();
    }
  }
}

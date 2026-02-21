import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/home_repository.dart';
import '../../../data/services/storage_service.dart';
import '../../../services/navigation_service.dart';
import '../../../data/models/category_model.dart';

class DashboardController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final HomeRepository _homeRepository = Get.find<HomeRepository>();
  final NavigationService _navService = Get.find<NavigationService>();

  final count = 0.obs;
  final tabIndex = 0.obs;
  final categories = <CategoryModel>[].obs;
  final isLoadingCategories = false.obs;

  // Header Info
  final userName = "User".obs;
  final userEmail = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserInfo();
    fetchCategories();
  }

  void _loadUserInfo() {
    final storage = Get.find<StorageService>();
    userName.value = storage.getUserName() ?? "Guest User";
    userEmail.value = storage.getUserEmail() ?? "";
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories.value = true;
      final fetchedCategories = await _homeRepository.getCategories(
        branchId: 1,
      );
      categories.assignAll(fetchedCategories);
    } catch (e) {
      // Error is handled silenty for UX, but should be logged in a real app
    } finally {
      isLoadingCategories.value = false;
    }
  }

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

import 'package:get/get.dart';
import '../../../data/providers/api_client.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/home_repository.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => HomeRepository(Get.find<ApiClient>()));
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}

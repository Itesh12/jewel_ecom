import 'package:get/get.dart';

class LoadingService extends GetxService {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<LoadingService> init() async {
    return this;
  }

  void show() {
    _isLoading.value = true;
  }

  void hide() {
    _isLoading.value = false;
  }
}

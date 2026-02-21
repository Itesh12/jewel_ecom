import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/services/storage_service.dart';

class ThemeController extends GetxController {
  final _storage = Get.find<StorageService>();
  final isDarkMode = true.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _storage.getIsDarkMode();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _storage.setIsDarkMode(isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  ThemeMode get themeMode =>
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
}

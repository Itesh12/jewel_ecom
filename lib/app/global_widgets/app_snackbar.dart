import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/values/app_colors.dart';

class AppSnackbar {
  static void showSuccess({String title = 'Success', required String message}) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  static void showError({String title = 'Error', required String message}) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 4),
    );
  }

  static void showInfo({String title = 'Info', required String message}) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.secondary,
      colorText: AppColors.primary,
      icon: const Icon(
        Icons.info_outline,
        color: AppColors.primary,
        size: 28,
      ), // Alert Info style
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}

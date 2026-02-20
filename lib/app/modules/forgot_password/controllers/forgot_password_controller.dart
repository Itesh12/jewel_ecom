import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> resetPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      // Simulate network delay for premium feel
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Password reset link sent to your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.white,
      );
      Get.back();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void resetPassword() {
    if (formKey.currentState!.validate()) {
      // TODO: Implement password reset logic
      Get.snackbar(
        'Success',
        'Password reset link sent to your email',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.back();
    }
  }
}

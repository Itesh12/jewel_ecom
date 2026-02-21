import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/alert_service.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _alertService = Get.find<AlertService>();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> resetPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      // simulate delay for premium feel, though real API will do this eventually
      await Future.delayed(const Duration(seconds: 1));

      _alertService.success('Password reset link sent to your email');
      Get.back();
    }
  }
}

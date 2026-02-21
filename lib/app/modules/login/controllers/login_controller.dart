import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../services/navigation_service.dart';
import '../../../data/errors/api_exceptions.dart';
import '../../../services/alert_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _authRepository = Get.find<AuthRepository>();
  final _navService = Get.find<NavigationService>();
  final _alertService = Get.find<AlertService>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        await _authRepository.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        _navService.toDashboard();
      } catch (e) {
        final message = e is AppException ? e.message : e.toString();
        _alertService.error(message ?? 'An unexpected error occurred');
      }
    }
  }

  void goToRegister() {
    _navService.toRegister();
  }

  void goToForgotPassword() {
    _navService.toForgotPassword();
  }
}

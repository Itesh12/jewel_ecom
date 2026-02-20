import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../services/navigation_service.dart';
import '../../../data/errors/api_exceptions.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _authRepository = Get.find<AuthRepository>();
  final _navService = Get.find<NavigationService>();
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      try {
        await _authRepository.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        _navService.toDashboard();
      } catch (e) {
        final message = e is AppException ? e.message : e.toString();
        Get.snackbar('Error', message ?? 'An unexpected error occurred');
      } finally {
        isLoading.value = false;
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

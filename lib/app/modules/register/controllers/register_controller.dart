import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../services/navigation_service.dart';
import '../../../data/errors/api_exceptions.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _authRepository = Get.find<AuthRepository>();
  final _navService = Get.find<NavigationService>();
  final isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      try {
        // Step 1: Check Eligibility
        final eligibility = await _authRepository.checkEligibility(
          emailController.text.trim(),
          mobileController.text.trim(),
        );

        if (eligibility.isEligible) {
          // Step 2: Register
          await _authRepository.register(
            nameController.text.trim(),
            emailController.text.trim(),
            mobileController.text.trim(),
            passwordController.text.trim(),
          );
          _navService.toDashboard();
        } else {
          Get.snackbar('Error', eligibility.message);
        }
      } catch (e) {
        final message = e is AppException ? e.message : e.toString();
        Get.snackbar('Error', message ?? 'An unexpected error occurred');
      } finally {
        isLoading.value = false;
      }
    }
  }

  void goToLogin() {
    _navService.goBack();
  }
}

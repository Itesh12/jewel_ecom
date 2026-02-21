import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../services/navigation_service.dart';
import '../../../data/errors/api_exceptions.dart';
import '../../../services/alert_service.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _authRepository = Get.find<AuthRepository>();
  final _navService = Get.find<NavigationService>();
  final _alertService = Get.find<AlertService>();

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
          // _navService.toVerifyOtp(email: emailController.text.trim());
          _navService.toDashboard();
          _alertService.success('Account created successfully!');
        } else {
          _alertService.error(eligibility.message);
        }
      } catch (e) {
        final message = e is AppException ? e.message : e.toString();
        _alertService.error(message ?? 'An unexpected error occurred');
      }
    }
  }

  void goToLogin() {
    _navService.goBack();
  }
}

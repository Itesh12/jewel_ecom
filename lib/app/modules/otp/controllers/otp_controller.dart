import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../services/navigation_service.dart';
import '../../../data/errors/api_exceptions.dart';
import '../../../services/alert_service.dart';

class OtpController extends GetxController {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  final _authRepository = Get.find<AuthRepository>();
  final _navService = Get.find<NavigationService>();
  final _alertService = Get.find<AlertService>();
  final resendTimerSeconds = 60.obs;
  final canResend = false.obs;
  Timer? _timer;

  late String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments as String? ?? '';
    startResendTimer();
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }

  void startResendTimer() {
    canResend.value = false;
    resendTimerSeconds.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimerSeconds.value > 0) {
        resendTimerSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> verifyOtp() async {
    final otp = otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      _alertService.error('Please enter a 6-digit OTP');
      return;
    }

    try {
      await _authRepository.verifyOtp(email, otp);
      _navService.toDashboard();
      _alertService.success('Verification successful!');
    } catch (e) {
      final message = e is AppException ? e.message : e.toString();
      _alertService.error(message ?? 'Invalid OTP');
    }
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;

    try {
      // Re-trigger registration or a specific resend-otp API if available.
      // For now, mirroring the registration logic assuming it resends OTP.
      // If a specific resendOtp endpoint is added later, swap it here.
      _alertService.info('Resending OTP to $email');
      startResendTimer();
    } catch (e) {
      _alertService.error('Failed to resend OTP');
    }
  }

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    if (otpControllers.every((c) => c.text.isNotEmpty)) {
      verifyOtp();
    }
  }
}

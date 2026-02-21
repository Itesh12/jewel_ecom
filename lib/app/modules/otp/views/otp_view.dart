import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jewel_ecom/app/global_widgets/custom_button.dart';
import '../../../../core/values/app_colors.dart';
import '../../login/views/auth_common_widgets.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(child: AuthBackground()),

          Positioned.fill(
            child: Column(
              children: [
                AuthHeader(
                  title: "Verification Code",
                  subtitle:
                      "Enter the code sent to your email to complete your registration",
                  onBack: Get.back,
                  delayMs: 200,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF121212) : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      boxShadow: isDark
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 20,
                                offset: const Offset(0, -5),
                              ),
                            ],
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 40.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AuthStaggeredFadeIn(
                            delayMs: 0,
                            child: Text(
                              "Verify OTP",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          AuthStaggeredFadeIn(
                            delayMs: 100,
                            child: Text(
                              "We've sent a 6-digit verification code to:\n${controller.email}",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.5),
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // OTP Boxes
                          AuthStaggeredFadeIn(
                            delayMs: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                6,
                                (index) => _OtpBox(
                                  index: index,
                                  controller: controller.otpControllers[index],
                                  focusNode: controller.focusNodes[index],
                                  onChanged: (value) =>
                                      controller.onOtpChanged(index, value),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Verify Button
                          AuthStaggeredFadeIn(
                            delayMs: 300,
                            child: CustomButton(
                              text: "Verify Code",
                              onPressed: controller.verifyOtp,
                              backgroundColor: AppColors.primary,
                              borderRadius: 16,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Resend Section
                          AuthStaggeredFadeIn(
                            delayMs: 400,
                            child: Obx(
                              () => _ResendSection(
                                onResend: controller.resendOtp,
                                canResend: controller.canResend.value,
                                timerSeconds:
                                    controller.resendTimerSeconds.value,
                              ),
                            ),
                          ),

                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  const _OtpBox({
    required this.index,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 45,
      height: 56,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1F1F1F)
            : AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: focusNode.hasFocus
              ? AppColors.primary
              : (isDark
                    ? Colors.white.withOpacity(0.05)
                    : AppColors.textSecondary.withValues(alpha: 0.1)),
          width: focusNode.hasFocus ? 1.5 : 1,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        cursorColor: AppColors.primary,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _ResendSection extends StatelessWidget {
  final VoidCallback onResend;
  final bool canResend;
  final int timerSeconds;

  const _ResendSection({
    required this.onResend,
    required this.canResend,
    required this.timerSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Didn't receive code?",
          style: TextStyle(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.5),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: canResend ? onResend : null,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            disabledForegroundColor: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.1),
          ),
          child: Text(
            canResend
                ? "Resend Verification Code"
                : "Resend in ${timerSeconds}s",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

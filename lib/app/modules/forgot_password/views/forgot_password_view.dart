import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_text_field.dart';
import '../controllers/forgot_password_controller.dart';
import '../../login/views/auth_common_widgets.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(child: AuthBackground()),
          Positioned.fill(
            child: Column(
              children: [
                // Header Section (Top Dark)
                AuthHeader(
                  title: "Restore Access",
                  subtitle:
                      "Don't worry, even the finest keys can be misplaced. Enter your email to begin recovery.",
                  onBack: Get.back,
                  delayMs: 200,
                ),

                // Bottom Card Container
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF121212), // Premium deep black card
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 40.0,
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            AuthStaggeredFadeIn(
                              delayMs: 0,
                              child: CustomTextField(
                                label: "Email Address",
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icons.email_outlined,
                                prefixIconColor: AppColors.primary,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  if (!GetUtils.isEmail(value)) {
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 48),
                            AuthStaggeredFadeIn(
                              delayMs: 0,
                              child: CustomButton(
                                text: "Send Reset Link",
                                onPressed: controller.resetPassword,
                                backgroundColor: AppColors.primary,
                                borderRadius: 16,
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
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

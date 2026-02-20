import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_text_field.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "Forgot Password?",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.primary,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Enter your email to receive a reset link",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 48),
                CustomTextField(
                  label: "Email",
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
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
                const SizedBox(height: 32),
                CustomButton(
                  text: "Send Reset Link",
                  onPressed: controller.resetPassword,
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

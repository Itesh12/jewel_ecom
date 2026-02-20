import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
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
                  "Welcome Back",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.primary,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Login to continue your journey",
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
                const SizedBox(height: 16),
                CustomTextField(
                  label: "Password",
                  controller: controller.passwordController,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.goToForgotPassword,
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(text: "Login", onPressed: controller.login),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: controller.goToRegister,
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

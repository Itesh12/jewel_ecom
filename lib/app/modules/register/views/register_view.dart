import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_text_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),
                  Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColors.primary,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Join us to explore exclusive jewelry",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    label: "Full Name",
                    controller: controller.nameController,
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Mobile Number",
                    controller: controller.mobileController,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone_android,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
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
                      if (value.length < 6) {
                        return 'Password must be at least 6 chars';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  CustomButton(text: "Sign Up", onPressed: controller.register),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: controller.goToLogin,
                        child: const Text(
                          "Sign In",
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
      ),
    );
  }
}

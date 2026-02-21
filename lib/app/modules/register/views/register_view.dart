import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_text_field.dart';
import '../controllers/register_controller.dart';
import '../../login/views/auth_common_widgets.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
                // Header Section (Top Dark)
                AuthHeader(
                  title: "Join the Elite",
                  subtitle:
                      "Discover the finest pieces and manage your jewelry portfolio",
                  onBack: controller.goToLogin,
                  delayMs: 200,
                ),

                // Bottom Card Container
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 40.0,
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AuthTabSwitcher(
                              isLogin: false,
                              onLoginTap: controller.goToLogin,
                              onRegisterTap: () {}, // Already on register
                            ),
                            const SizedBox(height: 40),

                            AuthStaggeredFadeIn(
                              delayMs: 0,
                              child: CustomTextField(
                                label: "Full Name",
                                controller: controller.nameController,
                                prefixIcon: Icons.person_outline,
                                prefixIconColor: AppColors.primary,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),

                            AuthStaggeredFadeIn(
                              delayMs: 0,
                              child: CustomTextField(
                                label: "Mobile Number",
                                controller: controller.mobileController,
                                keyboardType: TextInputType.phone,
                                prefixIcon: Icons.phone_android,
                                prefixIconColor: AppColors.primary,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter mobile';
                                  }
                                  return null;
                                },
                              ),
                            ),
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
                            const SizedBox(height: 20),

                            AuthStaggeredFadeIn(
                              delayMs: 0,
                              child: CustomTextField(
                                label: "Password",
                                controller: controller.passwordController,
                                obscureText: true,
                                prefixIcon: Icons.lock_outline,
                                prefixIconColor: AppColors.primary,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password too short';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 48),

                            AuthStaggeredFadeIn(
                              delayMs: 0,
                              child: CustomButton(
                                text: "Register",
                                onPressed: controller.register,
                                backgroundColor: AppColors.primary,
                                borderRadius: 16,
                              ),
                            ),
                            const SizedBox(height: 50),
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

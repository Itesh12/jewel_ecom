import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_text_field.dart';
import '../controllers/login_controller.dart';
import 'auth_common_widgets.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                  title: "Welcome Back",
                  subtitle:
                      "Sign in to continue your journey of timeless elegance",
                  onBack: Get.back,
                  delayMs: 200,
                ),

                // Bottom Card Container
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF121212) : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      border: isDark
                          ? Border.all(
                              color: Colors.white.withValues(alpha: 0.05),
                            )
                          : Border.all(
                              color: AppColors.primary.withValues(alpha: 0.1),
                            ),
                      boxShadow: isDark
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 30,
                                offset: const Offset(0, -10),
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
                            // Tab Switcher
                            AuthTabSwitcher(
                              isLogin: true,
                              onLoginTap: () {}, // Already on login
                              onRegisterTap: controller.goToRegister,
                            ),
                            const SizedBox(height: 40),

                            // Fields
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
                                  return null;
                                },
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Options Row
                            AuthStaggeredFadeIn(
                              delayMs: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Checkbox(
                                          value: false,
                                          onChanged: (v) {},
                                          activeColor: AppColors.primary,
                                          checkColor: Colors.black,
                                          side: BorderSide(
                                            color: isDark
                                                ? Colors.white24
                                                : AppColors.textSecondary
                                                      .withValues(alpha: 0.3),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Remember me",
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white60
                                              : AppColors.textPrimary
                                                    .withValues(alpha: 0.8),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: controller.goToForgotPassword,
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Login Button
                            AuthStaggeredFadeIn(
                              delayMs: 0,
                              child: CustomButton(
                                text: "Login",
                                onPressed: controller.login,
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

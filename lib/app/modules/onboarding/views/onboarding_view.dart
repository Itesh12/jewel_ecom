import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../global_widgets/custom_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image or Gradient (Placeholder)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.background,
                  AppColors.background,
                ], // Can replace with image
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discover\nTimeless Elegance",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColors.primary,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Explore our exclusive collection of premium jewelry tailored just for you.",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 48),
                  CustomButton(
                    text: "Get Started",
                    onPressed: controller.getStarted,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

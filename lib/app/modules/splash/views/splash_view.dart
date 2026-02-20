import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_strings.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundDark,
              Color(0xFF0F172A), // Darker Navy
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Logo
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.5, end: 1.0),
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: scale.clamp(0.0, 1.0),
                      child: child,
                    ),
                  );
                },
                child: const Icon(
                  Icons.diamond,
                  size: 100,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              // Animated Text
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: Opacity(opacity: value, child: child),
                  );
                },
                child: Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.primary,
                    fontSize: 32,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

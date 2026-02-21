import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../global_widgets/custom_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background with Rich Deep Glows
          Positioned.fill(child: _OnboardingBackground(isDark: isDark)),

          // Professional Layout
          SafeArea(
            child: Column(
              children: [
                // Top Navigation (Skip Button)
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Obx(
                      () => Visibility(
                        visible:
                            controller.currentPage.value !=
                            controller.slides.length - 1,
                        child: TextButton(
                          onPressed: controller.skip,
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white70,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            "SKIP",
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.7),
                              fontSize: 13,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: controller.slides.length,
                    itemBuilder: (context, index) {
                      return _OnboardingSlide(
                        data: controller.slides[index],
                        index: index,
                      );
                    },
                  ),
                ),

                // Bottom Control Center (Glassmorphism effect)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.03)
                            : Colors.black.withValues(alpha: 0.02),
                        border: Border(
                          top: BorderSide(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.black.withValues(alpha: 0.05),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Luxury Page Indicators
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              controller.slides.length,
                              (index) => _buildIndicator(context, index),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Elegant Primary Action
                          Obx(
                            () => CustomButton(
                              text:
                                  controller.currentPage.value ==
                                      controller.slides.length - 1
                                  ? "START YOUR JOURNEY"
                                  : "CONTINUE",
                              onPressed: controller.next,
                            ),
                          ),
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

  Widget _buildIndicator(BuildContext context, int index) {
    return Obx(() {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      bool isActive = controller.currentPage.value == index;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        height: 2,
        width: isActive ? 32 : 12,
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary
              : (isDark ? Colors.white24 : Colors.black12),
          borderRadius: BorderRadius.circular(1),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
      );
    });
  }
}

class _OnboardingSlide extends StatelessWidget {
  final OnboardingSlideData data;
  final int index;

  const _OnboardingSlide({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          // Professional Zoom + Float Animation
          _FloatingVisualAsset(index: index),

          const SizedBox(height: 60),

          // Staggered Text Entrance
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                _AnimatedText(
                  text: data.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 34,
                    height: 1.15,
                    fontWeight: FontWeight.w200,
                    letterSpacing: -0.5,
                    fontFamily: 'Playfair Display',
                  ),
                  delayMs: 100,
                ),
                const SizedBox(height: 24),
                _AnimatedText(
                  text: data.subtitle,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                    fontSize: 15,
                    height: 1.8,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.2,
                  ),
                  delayMs: 300,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _FloatingVisualAsset extends StatefulWidget {
  final int index;
  const _FloatingVisualAsset({required this.index});

  @override
  State<_FloatingVisualAsset> createState() => _FloatingVisualAssetState();
}

class _FloatingVisualAssetState extends State<_FloatingVisualAsset>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutQuart,
      builder: (context, scaleValue, child) {
        return AnimatedBuilder(
          animation: _floatController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 15 * _floatController.value),
              child: Transform.scale(
                scale: 0.8 + (0.2 * scaleValue),
                child: Opacity(
                  opacity: scaleValue.clamp(0.0, 1.0),
                  child: Container(
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.05),
                          blurRadius: 50,
                          spreadRadius: 20,
                        ),
                      ],
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.15),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Icon(
                      widget.index == 0
                          ? Icons.auto_awesome_rounded
                          : widget.index == 1
                          ? Icons.diamond_rounded
                          : Icons.verified_user_rounded,
                      size: 130,
                      color: AppColors.primary,
                      shadows: [
                        Shadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _AnimatedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int delayMs;

  const _AnimatedText({
    required this.text,
    required this.style,
    required this.delayMs,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutExpo,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Text(text, textAlign: TextAlign.center, style: style),
    );
  }
}

class _OnboardingBackground extends StatelessWidget {
  final bool isDark;
  const _OnboardingBackground({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: isDark ? AppColors.backgroundDark : AppColors.background,
        ),

        // Deep Gold Glow
        Positioned(
          top: -150,
          left: -100,
          child: _GlowCircle(
            color: AppColors.primary.withValues(alpha: isDark ? 0.12 : 0.08),
            size: 400,
          ),
        ),

        // Subtle Glow
        Positioned(
          bottom: 200,
          right: -100,
          child: _GlowCircle(
            color: isDark
                ? const Color(0xFF1E293B).withValues(alpha: 0.3)
                : AppColors.primary.withValues(alpha: 0.05),
            size: 500,
          ),
        ),

        // Center Accent
        Center(
          child: _GlowCircle(
            color: AppColors.primary.withValues(alpha: isDark ? 0.03 : 0.01),
            size: 600,
          ),
        ),
      ],
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}

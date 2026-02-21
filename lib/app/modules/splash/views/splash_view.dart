import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_strings.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          // Premium Radial Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: isDark
                    ? [
                        const Color(0xFF2C2C2C),
                        AppColors.backgroundDark,
                        const Color(0xFF000000),
                      ]
                    : [
                        const Color(0xFFFFFFFF),
                        AppColors.background,
                        const Color(0xFFF3F0E9),
                      ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),

          // Background subtle pattern or light effect
          Positioned.fill(
            child: Opacity(
              opacity: isDark ? 0.05 : 0.02,
              child: CustomPaint(painter: GridPainter(isDark: isDark)),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo with Gold Shimmer
                _buildAnimatedLogo(),
                const SizedBox(height: 32),

                // Animated Title with Shimmer
                _buildAnimatedTitle(context),

                const SizedBox(height: 8),

                // Animated Tagline
                _buildAnimatedTagline(context),
              ],
            ),
          ),

          // Bottom Progress Indicator
          Positioned(
            bottom: 60,
            left: 50,
            right: 50,
            child: _buildProgressBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (value * 0.2),
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    Colors.white.withOpacity(0.8),
                    AppColors.primary,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                  transform: SlidingGradientTransform(value: value),
                ).createShader(bounds);
              },
              child: const Icon(Icons.diamond, size: 110, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedTitle(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 10 * (1 - value)),
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Text(
        AppStrings.appName.toUpperCase(),
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          color: AppColors.primary,
          fontSize: 34,
          letterSpacing: 4.0,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }

  Widget _buildAnimatedTagline(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      builder: (context, value, child) {
        return Opacity(opacity: value.clamp(0.0, 1.0), child: child);
      },
      child: Text(
        "LUXURY IN EVERY DETAIL",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          fontSize: 10,
          letterSpacing: 2.5,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 2000),
      builder: (context, value, child) {
        return Column(
          children: [
            Container(
              height: 2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryDark, AppColors.primary],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SlidingGradientTransform extends GradientTransform {
  const SlidingGradientTransform({required this.value});

  final double value;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (value * 2 - 1), 0.0, 0.0);
  }
}

class GridPainter extends CustomPainter {
  final bool isDark;
  GridPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = isDark ? Colors.white : Colors.black
      ..strokeWidth = 1.0;

    for (var i = 0.0; i <= size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (var i = 0.0; i <= size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

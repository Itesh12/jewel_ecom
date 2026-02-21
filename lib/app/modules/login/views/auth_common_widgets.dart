import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/values/app_colors.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Container(
          color: isDark
              ? AppColors.backgroundDark
              : Theme.of(context).scaffoldBackgroundColor,
        ),
        Positioned(
          top: -100,
          left: -100,
          child: AuthGlow(
            color: isDark
                ? const Color(0x14D4AF37)
                : AppColors.primary.withValues(alpha: 0.1),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -150,
          right: -50,
          child: AuthGlow(
            color: isDark
                ? const Color(0x1FD4AF37)
                : AppColors.primary.withValues(alpha: 0.15),
            size: 500,
          ),
        ),
      ],
    );
  }
}

class AuthGlow extends StatelessWidget {
  final Color color;
  final double size;

  const AuthGlow({super.key, required this.color, required this.size});

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

class AuthStaggeredFadeIn extends StatelessWidget {
  final Widget child;
  final int delayMs;

  const AuthStaggeredFadeIn({
    super.key,
    required this.child,
    required this.delayMs,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeIn,
      builder: (context, value, _) {
        return Opacity(opacity: value.clamp(0.0, 1.0), child: child);
      },
    );
  }
}

class AuthTabSwitcher extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onLoginTap;
  final VoidCallback onRegisterTap;

  const AuthTabSwitcher({
    super.key,
    required this.isLogin,
    required this.onLoginTap,
    required this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 56,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF121212)
            : AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              text: "Login",
              isActive: isLogin,
              onTap: onLoginTap,
            ),
          ),
          Expanded(
            child: _TabButton(
              text: "Register",
              isActive: !isLogin,
              onTap: onRegisterTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive
              ? (isDark ? const Color(0xFF1F1F1F) : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isActive && !isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isActive
                ? AppColors.primary
                : (isDark
                      ? Colors.white38
                      : AppColors.textPrimary.withValues(alpha: 0.7)),
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  final int delayMs;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
    this.delayMs = 0,
  });

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double headerHeight =
        220 + topPadding; // Maintain exact parity with previous top+220 layout

    return Container(
      width: double.infinity,
      height: headerHeight,
      padding: EdgeInsets.fromLTRB(24, topPadding + 12, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onBack != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: onBack,
                behavior: HitTestBehavior.opaque,
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 24,
                ),
              ),
            ),
          const Spacer(),
          AuthStaggeredFadeIn(
            delayMs: delayMs,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 34,
                height: 1.1,
                fontWeight: FontWeight.w600,
                letterSpacing: -1.0,
                fontFamily: 'serif', // Fallback to serif for luxury look
              ),
            ),
          ),
          const SizedBox(height: 10),
          AuthStaggeredFadeIn(
            delayMs: delayMs + 100,
            child: Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, // Full opacity
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.5,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthLoadingOverlay extends StatelessWidget {
  const AuthLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}

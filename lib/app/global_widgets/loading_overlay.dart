import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../core/values/app_colors.dart';
import '../services/loading_service.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;

  const LoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final loadingService = Get.find<LoadingService>();

    return Stack(
      children: [
        child,
        Obx(() {
          if (!loadingService.isLoading) return const SizedBox.shrink();

          return Container(
            color: Colors.black.withValues(alpha: 0.7),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpinKitFadingCircle(color: AppColors.primary, size: 50.0),
                  const SizedBox(height: 20),
                  const Text(
                    'Processing Request...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

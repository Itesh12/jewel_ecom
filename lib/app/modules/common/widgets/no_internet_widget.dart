import 'package:flutter/material.dart';
import '../../../../core/values/app_colors.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back button
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 64,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 16),
              const Text(
                'No Internet Connection',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Please check your internet settings and try again.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(color: AppColors.primary),
              const SizedBox(height: 16),
              Text(
                'Reconnecting...',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.secondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

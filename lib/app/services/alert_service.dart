import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jewel_ecom/app/services/navigation_service.dart';
import '../../core/values/app_colors.dart';

class AlertService extends GetxService {
  final _navService = Get.find<NavigationService>();

  Future<AlertService> init() async {
    return this;
  }

  void success(String message) {
    _show(
      message: message,
      type: TypeInfo.success,
      backgroundColor: const Color(0xFF1F1F1F),
      textColor: Colors.white,
      iconColor: AppColors.primary,
    );
  }

  void error(String message) {
    _show(
      message: message,
      type: TypeInfo.error,
      backgroundColor: const Color(0xFF1F1F1F),
      textColor: Colors.white,
      iconColor: AppColors.error,
    );
  }

  void info(String message) {
    _show(
      message: message,
      type: TypeInfo.info,
      backgroundColor: const Color(0xFF1F1F1F),
      textColor: Colors.white,
      iconColor: Colors.blue,
    );
  }

  void _show({
    required String message,
    required TypeInfo type,
    required Color backgroundColor,
    required Color textColor,
    required Color iconColor,
  }) {
    final context = _navService.context;
    if (context == null) return;

    AlertInfo.show(
      context: context,
      text: message,
      typeInfo: type,
      position: MessagePosition.bottom,
      duration: 3,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
    );
  }
}

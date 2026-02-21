import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class NavigationService extends GetxService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<NavigationService> init() async {
    return this;
  }

  /// Safely get the current context from the navigator key.
  /// This is preferred over Get.context! for production-grade null safety.
  BuildContext? get context => navigatorKey.currentContext;

  // Generic Navigation Method
  Future<T?>? toNamed<T>(String route, {dynamic arguments}) {
    _logNavigation(route, arguments);
    return Get.toNamed<T>(route, arguments: arguments);
  }

  // Clear Stack and Navigate
  Future<T?>? offAllNamed<T>(String route, {dynamic arguments}) {
    _logNavigation(route, arguments, type: 'OffAllNamed');
    return Get.offAllNamed<T>(route, arguments: arguments);
  }

  // Replace current route
  Future<T?>? offNamed<T>(String route, {dynamic arguments}) {
    _logNavigation(route, arguments, type: 'OffNamed');
    return Get.offNamed<T>(route, arguments: arguments);
  }

  // Go Back with result
  void goBack<T>({T? result}) {
    Get.back<T>(result: result);
  }

  // Specific Helpers (optional, but good for type safety on critical paths)
  void toLogin() => offAllNamed(Routes.LOGIN);
  void toRegister() => toNamed(Routes.REGISTER);
  void toForgotPassword() => toNamed(Routes.FORGOT_PASSWORD);
  void toVerifyOtp({required String email}) =>
      toNamed(Routes.VERIFY_OTP, arguments: email);
  void toDashboard() => offAllNamed(Routes.DASHBOARD);
  void toHome() => offAllNamed(Routes.HOME);
  void toOnboarding() => offAllNamed(Routes.ONBOARDING);

  void _logNavigation(String route, dynamic args, {String type = 'ToNamed'}) {
    debugPrint('Navigation Service [$type]: $route | Args: $args');
  }
}

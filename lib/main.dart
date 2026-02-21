import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/config/environment.dart';
import 'app/controllers/network_manager.dart';
import 'app/data/services/storage_service.dart';
import 'app/routes/app_pages.dart';
import 'app/services/alert_service.dart';
import 'app/services/connectivity_service.dart';
import 'app/services/device_info_service.dart';
import 'app/services/navigation_service.dart';
import 'app/services/package_info_service.dart';
import 'app/services/loading_service.dart';
import 'app/global_widgets/loading_overlay.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment().initConfig(Environment.dev); // Initialize Environment

  // Core Services
  await Get.putAsync(() => NavigationService().init());
  await Get.putAsync(() => LoadingService().init());
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => AlertService().init());
  await Get.putAsync(() => ConnectivityService().init());
  await Get.putAsync(() => DeviceInfoService().init());
  await Get.putAsync(() => PackageInfoService().init());
  Get.put(NetworkManager()); // Not async, just put

  runApp(
    GetMaterialApp(
      title: "Jewel E-com",
      navigatorKey: Get.find<NavigationService>().navigatorKey,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return LoadingOverlay(child: child!);
      },
    ),
  );
}

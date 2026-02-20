import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'core/theme/app_theme.dart';
import 'app/config/environment.dart';
import 'app/data/services/storage_service.dart';
import 'app/services/navigation_service.dart';

import 'app/services/device_info_service.dart';
import 'app/services/package_info_service.dart';
import 'app/services/connectivity_service.dart';
import 'app/controllers/network_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment().initConfig(Environment.dev); // Initialize Environment

  // Core Services
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => ConnectivityService().init());
  await Get.putAsync(() => DeviceInfoService().init());
  await Get.putAsync(() => PackageInfoService().init());
  Get.put(NetworkManager()); // Not async, just put
  await Get.putAsync(() => NavigationService().init());

  runApp(
    GetMaterialApp(
      title: "Jewel E-com",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    ),
  );
}

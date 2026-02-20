import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class DeviceInfoService extends GetxService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, String> _deviceData = {};

  Future<DeviceInfoService> init() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfoPlugin.androidInfo;
        _deviceData = {
          'deviceType': 'ANDROID',
          'uuid': info.id,
          'deviceModel': '${info.manufacturer} ${info.model}',
          'os_version': 'Android ${info.version.release}',
        };
      } else if (Platform.isIOS) {
        final info = await _deviceInfoPlugin.iosInfo;
        _deviceData = {
          'deviceType': 'IOS',
          'uuid': info.identifierForVendor ?? '',
          'deviceModel': info.utsname.machine,
          'os_version': 'iOS ${info.systemVersion}',
        };
      } else {
        final info = await _deviceInfoPlugin.webBrowserInfo;
        _deviceData = {
          'deviceType': 'WEB',
          'uuid': info.userAgent ?? '',
          'deviceModel': info.browserName.name,
          'os_version': info.appVersion ?? '',
        };
      }
    } catch (e) {
      _deviceData = {
        'deviceType': 'UNKNOWN',
        'uuid': 'unknown',
        'deviceModel': 'Unknown',
        'os_version': 'Unknown',
      };
    }
    return this;
  }

  Map<String, String> get deviceData => _deviceData;
}

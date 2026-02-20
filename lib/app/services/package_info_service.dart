import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService extends GetxService {
  late PackageInfo _packageInfo;

  Future<PackageInfoService> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    return this;
  }

  String get version => _packageInfo.version;
  String get buildNumber => _packageInfo.buildNumber;
  String get packageName => _packageInfo.packageName;
  String get appName => _packageInfo.appName;

  String get packageInfoData => _packageInfo.toString();
}

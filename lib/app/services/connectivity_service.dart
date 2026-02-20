import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  Future<ConnectivityService> init() async {
    return this;
  }

  Future<bool> get isConnected async {
    final result = await Connectivity().checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}

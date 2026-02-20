import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../modules/common/widgets/no_internet_widget.dart';

class NetworkManager extends GetxService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxBool _isDialogOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // If any result in the list is NOT none, we have connection (simplified)
    bool isConnected = !results.contains(ConnectivityResult.none);

    if (!isConnected && !_isDialogOpen.value) {
      _isDialogOpen.value = true;
      Get.dialog(
        const NoInternetWidget(),
        barrierDismissible: false,
        useSafeArea: true,
      ).then(
        (_) => _isDialogOpen.value = false,
      ); // Reset if dismissed programmatically
    } else if (isConnected && _isDialogOpen.value) {
      _isDialogOpen.value = false;
      if (Get.isDialogOpen ?? false) {
        Get.back(); // Close dialog
      }
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}

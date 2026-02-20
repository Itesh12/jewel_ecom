import 'package:get/get.dart';
import '../models/auth_models.dart';
import '../providers/api_client.dart';
import '../providers/api_endpoints.dart';
import '../services/storage_service.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient(); // Singleton
  final StorageService _storageService = Get.find<StorageService>();

  Future<EligibilityResponse> checkEligibility(
    String email,
    String mobile,
  ) async {
    // Exceptions are now handled by ApiClient and thrown as AppExceptions
    final request = CheckEligibilityRequest(email: email, mobile: mobile);
    final response = await _apiClient.post(
      ApiEndpoints.authCheckEligibility,
      data: request.toJson(),
    );
    return EligibilityResponse.fromJson(response.data);
  }

  Future<AuthResponse> register(
    String name,
    String email,
    String mobile,
    String password,
  ) async {
    final request = RegisterRequest(
      name: name,
      email: email,
      mobile: mobile,
      password: password,
    );
    final response = await _apiClient.post(
      ApiEndpoints.authRegister,
      data: request.toJson(),
    );
    final authResponse = AuthResponse.fromJson(response.data);
    await _saveAuthSession(authResponse);
    return authResponse;
  }

  Future<AuthResponse> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final response = await _apiClient.post(
      ApiEndpoints.authLogin,
      data: request.toJson(),
    );
    final authResponse = AuthResponse.fromJson(response.data);
    await _saveAuthSession(authResponse);
    return authResponse;
  }

  Future<void> _saveAuthSession(AuthResponse response) async {
    if (response.token.isNotEmpty) {
      await _storageService.setToken(response.token);
    }
    if (response.refreshToken != null) {
      await _storageService.setRefreshToken(response.refreshToken!);
    }
    if (response.user != null) {
      await _storageService.setUserDetails(
        id: response.user!.userId,
        name: response.user!.name,
        email: response.user!.email,
      );
    }
  }
}

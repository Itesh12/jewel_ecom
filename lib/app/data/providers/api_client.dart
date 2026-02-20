import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:retry/retry.dart';
import '../../config/environment.dart';
import '../errors/api_exceptions.dart';
import '../services/storage_service.dart';
import '../../services/navigation_service.dart';
import '../../services/device_info_service.dart';
import '../../services/package_info_service.dart';
import '../../services/connectivity_service.dart';

class ApiClient extends GetxService {
  late Dio _dio;
  final StorageService _storageService = Get.find<StorageService>();
  final NavigationService _navService = Get.find<NavigationService>();
  final DeviceInfoService _deviceInfo = Get.find<DeviceInfoService>();
  final PackageInfoService _packageInfo = Get.find<PackageInfoService>();
  final ConnectivityService _connectivity = Get.find<ConnectivityService>();

  // Singleton instance
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  ApiClient._internal() {
    final config = Environment().config;
    _dio = Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl,
        connectTimeout: Duration(milliseconds: config.connectTimeout),
        receiveTimeout: Duration(milliseconds: config.receiveTimeout),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    _dio.interceptors.addAll([
      _EnterpriseInterceptor(),
      _AuthInterceptor(_storageService, _navService),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    ]);

    // Ignore SSL errors for development
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = _storageService.getToken();
    final headers = <String, String>{
      'Accept-Language': '*',
      'Connection': 'Keep-Alive',
      'appType': 'JEWEL_ECOM_APP',
      'requestFrom': 'MOBILE',
      'packageInfo': _packageInfo.packageInfoData,
      'deviceInfo': _deviceInfo.deviceData.toString(),
      // 'devicetoken': await AppMessaging().getToken(), // TODO: Add FCM
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<void> _preCallCheck() async {
    final isConnected = await _connectivity.isConnected;
    if (!isConnected) {
      throw FetchDataException('No internet connection', 'Pre-Call Check');
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await _preCallCheck();
    final dynamicHeaders = await _getHeaders();
    final requestOptions = options ?? Options();
    requestOptions.headers = {
      ...requestOptions.headers ?? {},
      ...dynamicHeaders,
    };

    const r = RetryOptions(maxAttempts: 3);
    return r.retry(
      () => _dio
          .get(
            path,
            queryParameters: queryParameters,
            options: requestOptions,
            cancelToken: cancelToken,
          )
          .catchError((e) => throw _handleError(e)),
      retryIf: (e) =>
          e is DioException &&
          (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout),
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await _preCallCheck();
    final dynamicHeaders = await _getHeaders();
    final requestOptions = options ?? Options();
    requestOptions.headers = {
      ...requestOptions.headers ?? {},
      ...dynamicHeaders,
    };

    // If data is FormData, let Dio handle Content-Type (remove it if set to json)
    if (data is FormData) {
      requestOptions.headers?.remove('Content-Type');
    }

    const r = RetryOptions(maxAttempts: 3);
    return r.retry(
      () => _dio
          .post(
            path,
            data: data,
            queryParameters: queryParameters,
            options: requestOptions,
            cancelToken: cancelToken,
          )
          .catchError((e) => throw _handleError(e)),
      retryIf: (e) =>
          e is DioException &&
          (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout),
    );
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await _preCallCheck();
    final dynamicHeaders = await _getHeaders();
    final requestOptions = options ?? Options();
    requestOptions.headers = {
      ...requestOptions.headers ?? {},
      ...dynamicHeaders,
    };

    // If data is FormData, let Dio handle Content-Type
    if (data is FormData) {
      requestOptions.headers?.remove('Content-Type');
    }

    const r = RetryOptions(maxAttempts: 3);
    return r.retry(
      () => _dio
          .put(
            path,
            data: data,
            queryParameters: queryParameters,
            options: requestOptions,
            cancelToken: cancelToken,
          )
          .catchError((e) => throw _handleError(e)),
      retryIf: (e) =>
          e is DioException &&
          (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout),
    );
  }

  // Similar implementations for PUT and DELETE would follow the same pattern
  // For brevity, repeating logic for PUT/DELETE below is omitted but implied to be updated similarly.

  dynamic _handleError(DioException e) {
    if (e.error is HandshakeException) {
      return FetchDataException('Security Check Failed', e.requestOptions.path);
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw FetchDataException('Network timeout', e.requestOptions.path);
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400:
            throw BadRequestException(
              e.response?.data['message'] ?? 'Bad request',
              e.requestOptions.path,
            );
          case 401:
          case 403:
            throw UnauthorisedException(
              e.response?.data['message'] ?? 'Unauthorized',
              e.requestOptions.path,
            );
          case 404:
            throw FetchDataException(
              'Resource not found',
              e.requestOptions.path,
            );
          case 500:
          default:
            throw FetchDataException(
              'Server error: ${e.response?.statusCode}',
              e.requestOptions.path,
            );
        }
      case DioExceptionType.cancel:
        throw FetchDataException('Request cancelled', e.requestOptions.path);
      case DioExceptionType.connectionError:
        throw FetchDataException(
          'No internet connection',
          e.requestOptions.path,
        );
      default:
        throw FetchDataException(
          'Unknown error occurred',
          e.requestOptions.path,
        );
    }
  }
}

class _EnterpriseInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Enterprise-Code'] = 'KBABU';
    super.onRequest(options, handler);
  }
}

class _AuthInterceptor extends Interceptor {
  final StorageService _storageService;
  final NavigationService _navService;

  _AuthInterceptor(this._storageService, this._navService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _storageService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // TODO: Implement Token Refresh Logic Here
      // 1. Lock Request
      // 2. Call Refresh Token API
      // 3. Update Token
      // 4. Unlock and Retry Request

      // For now, logout and redirect
      _storageService.clearAuth();
      _navService.toLogin();
    }
    super.onError(err, handler);
  }
}

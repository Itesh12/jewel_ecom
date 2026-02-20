abstract class BaseConfig {
  String get apiBaseUrl;
  int get connectTimeout;
  int get receiveTimeout;
}

class DevConfig implements BaseConfig {
  @override
  String get apiBaseUrl => 'https://217.217.249.94:8008/';

  @override
  int get connectTimeout => 30000;

  @override
  int get receiveTimeout => 30000;
}

class ProdConfig implements BaseConfig {
  @override
  String get apiBaseUrl => 'https://api.jewelecom.com/'; // Placeholder

  @override
  int get connectTimeout => 30000;

  @override
  int get receiveTimeout => 30000;
}

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String dev = 'DEV';
  static const String prod = 'PROD';

  late BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.prod:
        return ProdConfig();
      case Environment.dev:
      default:
        return DevConfig();
    }
  }
}

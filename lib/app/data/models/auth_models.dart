class CheckEligibilityRequest {
  final String enterpriseCode;
  final String email;
  final String mobile;

  CheckEligibilityRequest({
    this.enterpriseCode = 'KBABU',
    required this.email,
    required this.mobile,
  });

  Map<String, dynamic> toJson() => {
    'enterpriseCode': enterpriseCode,
    'email': email,
    'mobile': mobile,
  };
}

class RegisterRequest {
  final String enterpriseCode;
  final String name;
  final String email;
  final String mobile;
  final String password;

  RegisterRequest({
    this.enterpriseCode = 'KBABU',
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'enterpriseCode': enterpriseCode,
    'name': name,
    'email': email,
    'mobile': mobile,
    'password': password,
  };
}

class LoginRequest {
  final String enterpriseCode;
  final String email;
  final String password;

  LoginRequest({
    this.enterpriseCode = 'KBABU',
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'enterpriseCode': enterpriseCode,
    'email': email,
    'password': password,
  };
}

class AuthResponse {
  final String token;
  final String? refreshToken;
  final User? user;
  final String? message;

  AuthResponse({
    required this.token,
    this.refreshToken,
    this.user,
    this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      message: json['message'],
    );
  }
}

class User {
  final int userId;
  final String name;
  final String email;
  final String? mobile;
  final String? role;

  User({
    required this.userId,
    required this.name,
    required this.email,
    this.mobile,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'],
      role: json['role'],
    );
  }
}

class EligibilityResponse {
  final bool isEligible;
  final bool isEmailAvailable;
  final bool isMobileAvailable;
  final String message;

  EligibilityResponse({
    required this.isEligible,
    required this.isEmailAvailable,
    required this.isMobileAvailable,
    required this.message,
  });

  factory EligibilityResponse.fromJson(Map<String, dynamic> json) {
    return EligibilityResponse(
      isEligible: json['isEligible'] ?? false,
      isEmailAvailable: json['isEmailAvailable'] ?? false,
      isMobileAvailable: json['isMobileAvailable'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

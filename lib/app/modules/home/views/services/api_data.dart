

String hsvrApiBaseUrl = 'http://54.251.132.179:8000';

// POST Register scenario
class PostRegisterData {

  PostRegisterData({
    required this.email,
    required this.password,
    required this.fullName,
    required this.birthDate,
    required this.pregnancyStatus,
    required this.interests
  });
  late final String email;
  late final String password;
  late final String fullName;
  late final String birthDate;
  late final String pregnancyStatus;
  late final List<String> interests;

  PostRegisterData.fromJson(Map<String, dynamic> json){
    email = json['email'];
    password = json['password'];
    fullName = json['full_name'];
    birthDate = json['birth_date'];
    pregnancyStatus = json['pregnancy_status'];
    interests = json['interests'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['full_name'] = fullName;
    _data['birth_date'] = birthDate;
    _data['pregnancy_status'] = pregnancyStatus;
    _data['interests'] = interests;
    return _data;
  }
}


// POST Data scenario
class PostHsvrModel {
  PostHsvrModel({
    required this.success,
    required this.data,
    required this.message,
    required this.error,
  });
  late final String? success;
  late final PostHsvrData? data;
  late final String? message;
  late final String? error;

  PostHsvrModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = PostHsvrData.fromJson(json['data']);
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data?.toJson();
    _data['message'] = message;
    _data['error'] = error;
    return _data;
  }
}

class PostHsvrData {
  PostHsvrData({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
  });
  late final String? id;
  late final String? accessToken;
  late final String? refreshToken;

  PostHsvrData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['access_token'] = accessToken;
    _data['refresh_token'] = refreshToken;
    return _data;
  }
}

// GET scenario

// PATCH scenario

// PUT scenario



    // OldBaseUrl: http://54.251.132.179:8000
    // BaseUrl: http://54.169.131.201:8000
    // POST REGISTER
    // Authorization:
    //   Username: "FE6zmxW4sX"
    //   Password: "VPvVHc25Mx"
    //
    // Header:
    //   Content-Type: "application/json"
    //   Content-Length: <calculated when request is sent>
    //   Host: <calculated when request is sent>
    //   UserAgent: ...
    //   Accept: '*/*'
    //   Accept-Encoding: "gzip, deflate, br"
    //   Connection: "keep-alive"
    //
    // Body:
    // {
    //     "email": "kang-bakso@harakirimail.com",
    //     "password": "minimal8",
    //     "full_name": "Kang Bakso",
    //     "birth_date": "1990-01-01",
    //     "pregnancy_status": "eeb423f4-60f2-42d7-9c3e-73bec13097ab",
    //     "interests": [
    //         "42ac0022-c7a6-4152-89d7-6676afae8772",
    //         "4d71a229-e88a-40fe-ad84-aa38134603c1"
    //     ]
    // }


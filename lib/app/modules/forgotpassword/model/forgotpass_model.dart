class ForgotPasswordModel {
  ForgotPasswordModel({
    required this.success,
    required this.data,
    required this.message,
    required this.error,
  });
  late final String? success;
  late final Data? data;
  late final String? message;
  late final String? error;

  ForgotPasswordModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
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

class Data {
  Data({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
  });
  late final String? id;
  late final String? accessToken;
  late final String? refreshToken;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
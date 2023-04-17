class PrivacyPolicyModel {
  final String? success;
  final Data? data;
  final dynamic message;
  final dynamic error;

  PrivacyPolicyModel({
    this.success,
    this.data,
    this.message,
    this.error,
  });

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json)
      : success = json['success'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? Data.fromJson(json['data'] as Map<String, dynamic>)
            : null,
        message = json['message'],
        error = json['error'];

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data?.toJson(),
    'message': message,
    'error': error
  };
}

class Data {
  final String? id;
  final bool? isActive;
  final String? type;
  final dynamic platform;
  final dynamic version;
  final String? textContent;
  final dynamic jsonContent;

  Data({
    required this.id,
    required this.isActive,
    required this.type,
    required this.platform,
    required this.version,
    required this.textContent,
    required this.jsonContent,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        isActive = json['is_active'] as bool?,
        type = json['type'] as String?,
        platform = json['platform'],
        version = json['version'] as String?,
        textContent = json['text_content'],
        jsonContent = json['json_content'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'is_active': isActive,
    'type': type,
    'platform': platform,
    'version': version,
    'text_content': textContent,
    'json_content': jsonContent,
  };
}
class ResetPasswordModel {
  final String? success;
  final Data? data;
  final dynamic message;
  final dynamic error;

  ResetPasswordModel({
    this.success,
    this.data,
    this.message,
    this.error,
  });

  ResetPasswordModel.fromJson(Map<String, dynamic> json)
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

  Data({
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) : id = json['id'] as String?;

  Map<String, dynamic> toJson() => {'id': id};
}

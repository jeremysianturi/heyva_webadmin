
import 'package:heyva_web_admin/app/modules/home/model/read_article_data.dart';

class GetUserList {
  GetUserList({
    required this.success,
    required this.data,
    required this.message,
    required this.error,
    required this.links,
    required this.count
  });

  late String? success;
  late List<GetUserData>? data;
  late String? message;
  late String? error;
  late GetChainLinks? links;          // next/previous page links
  late int? count;                    // number of articles

  GetUserList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List).map((e) => GetUserData.fromJson(e)).toList();
    message = json['message'];
    error = json['error'];
    links = GetChainLinks.fromJson(json['links']);
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic> {};

    _data['success'] = success;
    _data['data'] = data?.map((e) => e.toJson()).toList();
    _data['message'] = message;
    _data['error'] = error;
    _data['links'] = links;
    _data['count'] = count;
    return _data;
  }
}

class GetUserData {

  GetUserData({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.isVerified,
    required this.lastLogin,
    required this.profile,
    required this.avatar
  });

  late String? id;
  late String? username;
  late String? email;
  late String? phoneNumber;
  late bool? isVerified;
  late String? lastLogin;
  late ProfileData? profile;
  late String? avatar;

  GetUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    isVerified = json['is_verified'];
    lastLogin = json['last_login'];
    profile = ProfileData.fromJson(json['profile']);
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['phone_number'] = phoneNumber;
    _data['is_verified'] = isVerified;
    _data['last_login'] = lastLogin;
    _data['profile'] = profile;
    _data['avatar'] = avatar;
    return _data;
  }
}

class ProfileData {

  ProfileData({
    required this.code,
    required this.fullName,
    required this.avatar
  });

  late String? code;
  late String? fullName;
  late String? avatar;

  ProfileData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    fullName = json['full_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['code'] = code;
    _data['full_name'] = fullName;
    _data['avatar'] = avatar;
    return _data;
  }
}

class UserListTable {
  String id;
  String username;
  String email;
  String avatar;
  String lastLogin;

  UserListTable({required this.id, required this.username, required this.email, required this.avatar, required this.lastLogin});
}
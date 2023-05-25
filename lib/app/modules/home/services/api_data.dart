

// String heyApiBaseUrl = 'http://54.169.131.201:8000';

// POST `article attachment`
//       {
//          "success": "Success",
//          "data": [
//            {
//              "id": "d659f11f-474b-4c9e-bf4d-23e7f69bb2d3",
//              "article": null,
//              "attachment": "https://heyva.s3.ap-southeast-1.amazonaws.com/article/202305072040-heyva_logo.svg"
//            }
//          ],
//          "message": null,
//          "error": null
//       }



// POST Register scenario
class PostRegisterData {

  PostRegisterData();

  PostRegisterData.fromJson(Map<String, dynamic> json){
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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

// POST Login scenario
// {{heyApiBaseUrl}}/api/v1/users/login


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


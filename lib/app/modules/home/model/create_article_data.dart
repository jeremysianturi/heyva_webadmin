

// RESPONSE: registering new article by posting Article Attachment
class CreateModel {
  CreateModel({
    required this.success, required this.data, required this.message, required this.error
  });
  late final String? success;
  late final CreateData? data;
  late final String? message;
  late final String? error;

  CreateModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = CreateData.fromJson(json['data']);
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

class CreateData {
  CreateData({
    required this.id, required this.article, required this.attachment
  });

  late final String? id;
  late final String? article;
  late final String? attachment;

  CreateData.fromJson(List<dynamic> json) {
    id = json[0]['id'];
    article = json[0]['article'];
    attachment = json[0]['attachment'];
  }

  List<dynamic> toJson() {
    final data = <dynamic>[{}];
    data[0]['id'] = id!;
    data[0]['article'] = article!;
    data[0]['attachment'] = attachment!;
    return data;
  }
}

// RESPONSE: posting new article by posting Article Attachment
class PostArticleModel {
  PostArticleModel({
    required this.success, required this.data, required this.message, required this.error
  });
  late final String? success;
  late final PostArticleData? data;
  late final String? message;
  late final String? error;

  PostArticleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = PostArticleData.fromJson(json['data']);
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

class PostArticleData {
  PostArticleData({required this.id});

  late final String? id;

  PostArticleData.fromJson(json) {
    id = json['id'];
  }

  toJson() {
    final data = {};
    data['id'] = id!;
    return data;
  }
}

Map<String, String> tagsList = {
  'new born': '8f69d168-1f3c-4543-8bea-9ad6d809b15c',
  'giving birth': '89b2aae1-7981-48da-ae9f-7116f1b5e007',
  'getting pregnant': 'a4687ded-9cab-445b-86e3-6cf3e52ee2ce',
};

import 'package:json_annotation/json_annotation.dart';


// RESPONSE: registering new article by posting Article Attachment
class AttArticleModel {
  AttArticleModel({
    required this.success, required this.data, required this.message, required this.error
  });
  late final String? success;
  late final AttArticleData? data;
  late final String? message;
  late final String? error;

  AttArticleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = AttArticleData.fromJson(json['data']);
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

class AttArticleData {
  AttArticleData({
    required this.id, required this.article, required this.attachment
  });

  late final String? id;
  late final String? article;
  late final String? attachment;

  AttArticleData.fromJson(List<dynamic> json) {
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

// RESPONSE: tags list query by type
// class TagsArticleModel {
//   TagsArticleModel({
//     required this.success, required this.data, required this.message, required this.error
//   });
//   late final String? success;
//   late final List<dynamic>? data;
//   late final String? message;
//   late final String? error;
//
//   TagsArticleModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     data = TagsData.fromJson(json['data']) as List<dynamic>;
//     message = json['message'];
//     error = json['error'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic> {};
//
//     _data['success'] = success!;
//     _data['data'] = data?.map((e) => e.toJson());
//     _data['message'] = message;
//     _data['error'] = error;
//     return _data;
//   }
// }
//
// class TagsData {
//   TagsData({
//     required this.id, required this.type, required this.name,
//     required this.parent, required this.icon, required this.value
//   });
//
//   late final String? id;
//   late final String? type;
//   late final String? name;
//   late final String? parent;
//   late final String? icon;
//   late final String? value;
//
//   TagsData.fromJson(List<dynamic> json) {
//       id = json[0]['id'];
//       type = json[0]['type'];
//       name = json[0]['name'];
//       parent = json[0]['parent'];
//       icon = json[0]['icon'];
//       value = json[0]['value'];
//   }
//
//   Map<String, dynamic> toJson(e) {
//     final data = <String, dynamic> {};
//     data[e]['id'] = id!;
//     data[e]['type'] = type!;
//     data[e]['name'] = name!;
//     data[e]['parent'] = parent!;
//     data[e]['icon'] = icon!;
//     data[e]['value'] = value!;
//     return data;
//   }
// }

@JsonSerializable()
class TagsArticleModel{

  @JsonKey(name : "success")
  String? success;

  @JsonKey(name : "data")
  List<TagsData>? data;

  @JsonKey(name : "message")
  String? message;

  @JsonKey(name : "error")
  String? error;

  TagsArticleModel({required this.success, required this.data, required this.message, required this.error});

  factory TagsArticleModel.fromJson(Map<String, dynamic> json) => _$TagsArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$TagsArticleModelToJson(this);
}

@JsonSerializable()
class TagsData {

  @JsonKey(name : "id")
  String? id;

  @JsonKey(name : "type")
  String? type;

  @JsonKey(name : "name")
  String? name;

  @JsonKey(name : "parent")
  String? parent;

  @JsonKey(name : "icon")
  String? icon;

  @JsonKey(name : "value")
  String? value;

  TagsData({required this.id, required this.type, required this.name, required this.parent, required this.icon, required this.value});

  factory TagsData.fromJson(Map<String, dynamic> json) => _$TagsDataFromJson(json);
  Map<String, dynamic> toJson() => _$TagsDataToJson(this);

}

TagsArticleModel _$TagsArticleModelFromJson(Map<String, dynamic> json) =>
    TagsArticleModel(
      success: json['success'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) => TagsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$TagsArticleModelToJson(TagsArticleModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
      'error': instance.error,
    };

TagsData _$TagsDataFromJson(Map<String, dynamic> json) => TagsData(
  id: json['id'] as String?,
  type: json['type'] as String?,
  name: json['name'] as String?,
  parent: json['parent'] as String?,
  icon: json['icon'] as String?,
  value: json['value'] as String?,
);

Map<String, dynamic> _$TagsDataToJson(TagsData instance) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'name': instance.name,
  'parent': instance.parent,
  'icon': instance.icon,
  'value': instance.value,
};

class TagIdName {
  String id;
  String name;
  TagIdName({required this.id, required this.name});
}
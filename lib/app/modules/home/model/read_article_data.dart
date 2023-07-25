
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

class GetArticleList {
  GetArticleList({
    required this.success,
    required this.data,
    required this.message,
    required this.error,
    required this.links,
    required this.count
  });

  late String? success;
  late List<GetArticleData>? data;
  late String? message;
  late String? error;
  late GetChainLinks? links;          // next/previous page links
  late int? count;                    // number of articles

  GetArticleList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List).map((e) => GetArticleData.fromJson(e)).toList();
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

class GetArticleData {

  GetArticleData({
    required this.id,
    required this.title,
    required this.tags,
    required this.renderedBody,
    required this.creator,
    required this.banner,
    required this.thumbnail
  });

  late String? id;                  // article id
  late String? title;               // article title
  late List<GetArticleTags>? tags;  // article tags
  late String? renderedBody;        // article content
  late String? creator;
  late String? banner;
  late String? thumbnail;

  GetArticleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    tags = (json['tags'] as List).map((e) => GetArticleTags.fromJson(e)).toList();
    renderedBody = json['rendered_body'];
    creator = json['creator'];
    banner = json['banner'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['id'] = id;
    _data['title'] = title;
    _data['tags'] = tags?.map((e) => e.toJson()).toList();
    _data['rendered_body'] = renderedBody;
    _data['creator'] = creator;
    _data['banner'] = banner;
    _data['thumbnail'] = thumbnail;
    return _data;
  }
}
class GetChainLinks {
  GetChainLinks({required this.next, required this.previous});

  late String? next;      // article id
  late String? previous;  // article title

  GetChainLinks.fromJson(Map<String, dynamic> json) {
      next = json['next'];
      previous = json['previous'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['next'] = next;
    _data['previous'] = previous;
    return _data;
  }
}

class GetArticleTags {
  GetArticleTags({required this.id, required this.tag});

  late String? id;
  late GetTagsData? tag;

  GetArticleTags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = GetTagsData.fromJson(json['tag']);
  }

  Map<String, dynamic> toJson() {
      final _data = <String, dynamic>{};

    _data['id'] = id;
    _data['tag'] = tag?.toJson();
    return _data;
  }
}

class GetTagsData {
  GetTagsData({
    required this.id,
    required this.type,
    required this.name,
    required this.parent,
    required this.icon,
    required this.value
  });

  late String? id;
  late String? type;
  late String? name;
  late String? parent;
  late String? icon;
  late String? value;

  GetTagsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    parent = json['parent'];
    icon = json['icon'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['id'] = id;
    _data['type'] = type;
    _data['name'] = name;
    _data['parent'] = parent;
    _data['icon'] = icon;
    _data['value'] = value;
    return _data;
  }
}

class ArticleListTable {
  String id;
  String title;
  String? creator;
  // List<String?> tags;
  String? tags;
  // String htmlBody;

  ArticleListTable({required this.id, required this.title, this.creator, required this.tags/*, required this.htmlBody*/});
}
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

class UpdateArticleModel {
  UpdateArticleModel({
    required this.success, required this.data, required this.message, required this.error
  });
  late final String? success;
  late final UpdateArticleData? data;
  late final String? message;
  late final String? error;

  UpdateArticleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = UpdateArticleData.fromJson(json['data']);
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

class UpdateArticleData {
  UpdateArticleData({required this.id});

  late final String? id;

  UpdateArticleData.fromJson(json) {
    id = json['id'];
  }

  toJson() {
    final data = {};
    data['id'] = id!;
    return data;
  }
}

class DeleteArticleModel {
  DeleteArticleModel({
    required this.success, required this.data, required this.message, required this.error
  });
  late final String? success;
  late final DeleteArticleData? data;
  late final String? message;
  late final String? error;

  DeleteArticleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = DeleteArticleData.fromJson(json['data']);
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

class DeleteArticleData {
  DeleteArticleData({required this.id});

  late final String? id;

  DeleteArticleData.fromJson(json) {
    id = json['id'];
  }

  toJson() {
    final data = {};
    data['id'] = id!;
    return data;
  }
}
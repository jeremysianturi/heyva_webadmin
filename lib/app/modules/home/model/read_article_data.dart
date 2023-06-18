
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
  List<String?> tags;
  String htmlBody;
  String? creator;

  ArticleListTable({required this.id, required this.title, required this.tags, required this.htmlBody, this.creator});
}
/*******************************************************************************
 *  Below are exercise draft to define json serializable read_client instance  *
 ******************************************************************************/
// class GetArticleList {
//   GetArticleList({
//     required this.success,
//     required this.data,
//     required this.message,
//     required this.error,
//     required this.links,
//     required this.count
//   });
//
//   late String? success;
//   late List<GetArticleData>? data;
//   late String? message;
//   late String? error;
//   late List<GetChainLinks>? links;          // next/previous page links
//   int? count;                          // number of articles
//
//   GetArticleList.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     data = GetArticleData.fromJson(json['data']).toJson() as List<GetArticleData>?;
//     message = json['message'];
//     error = json['error'];
//     links = GetChainLinks.fromJson(json['links']).toJson() as List<GetChainLinks>?;
//     count = json['count'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//
//     _data['success'] = success;
//     _data['data'] = data?.map((e) => e.toJson()).toList();
//     // _data['data'] = data?.toJson();
//     _data['message'] = message;
//     _data['error'] = error;
//     _data['links'] = links?.map((e) => e.toJson()).toList();
//     // _data['links'] = links?.toJson();
//     _data['count'] = count;
//     return _data;
//   }
// }
//
// class GetArticleData {
//
//   GetArticleData({
//     required this.id,
//     required this.title,
//     required this.tags,
//     required this.renderedBody,
//     required this.creator,
//     required this.banner,
//     required this.thumbnail
//   });
//
//   late String? id; // article id
//   late String? title; // article title
//   late List<GetArticleTags>? tags; // article tags
//   late String? renderedBody; // article content
//   late String? creator;
//   late String? banner;
//   late String? thumbnail;
//
//   GetArticleData.fromJson(List<dynamic> json) {
//     id = json[0]['id'];
//     title = json[0]['title'];
//     tags = GetArticleTags.fromJson(json[0]['tags']).toJson() as List<GetArticleTags>?;
//     renderedBody = json[0]['rendered_body'];
//     creator = json[0]['creator'];
//     banner = json[0]['banner'];
//     thumbnail = json[0]['thumbnail'];
//   }
//
//   List<dynamic> toJson() {
//     final _data = <dynamic>[{}];
//
//     _data[0]['id'] = id;
//     _data[0]['title'] = title;
//     _data[0]['tags'] = tags?.map((e) => e.toJson()).toList();
//     // _data['tags'] = tags?.toJson();
//     _data[0]['rendered_body'] = renderedBody;
//     _data[0]['creator'] = creator;
//     _data[0]['banner'] = banner;
//     _data[0]['thumbnail'] = thumbnail;
//     return _data;
//   }
// }
// class GetChainLinks {
//   GetChainLinks({required this.next, required this.previous});
//
//   late String? next; // article id
//   late String? previous; // article title
//
//   GetChainLinks.fromJson(List<dynamic> json) {
//   next = json[0]['next'];
//   previous = json[0]['previous'];
//   }
//
//   List<dynamic> toJson() {
//   final _data = <dynamic>[{}];
//
//   _data[0]['next'] = next;
//   _data[0]['previous'] = previous;
//   return _data;
//   }
// }
//
// class GetArticleTags {
//   GetArticleTags({required this.id, required this.tag });
//
//   late String? id;
//   late List<GetTagsData>? tag;
//
//   GetArticleTags.fromJson(List<dynamic> json) {
//     id = json[0]['id'];
//     tag = GetTagsData.fromJson(json[0]['tag']).toJson() as List<GetTagsData>;
//   }
//
//   List<dynamic> toJson() {
//     final _data = <dynamic>[{}];
//
//     _data[0]['id'] = id;
//     _data[0]['tag'] = tag?.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }
//
// class GetTagsData {
//   GetTagsData({
//     required this.id,
//     required this.type,
//     required this.name,
//     required this.parent,
//     required this.icon,
//     required this.value
//   });
//
//   late String? id;
//   late String? type;
//   late String? name;
//   late String? parent;
//   late String? icon;
//   late String? value;
//
//   GetTagsData.fromJson(List<dynamic> json) {
//     id = json[0]['id'];
//     type = json[0]['type'];
//     name = json[0]['name'];
//     parent = json[0]['parent'];
//     icon = json[0]['icon'];
//     value = json[0]['value'];
//   }
//
//   List<dynamic> toJson() {
//     final _data = <dynamic>[{}];
//
//     _data[0]['id'] = id;
//     _data[0]['type'] = type;
//     _data[0]['name'] = name;
//     _data[0]['parent'] = parent;
//     _data[0]['icon'] = icon;
//     _data[0]['value'] = value;
//     return _data;
//   }
// }

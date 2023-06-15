import 'package:json_annotation/json_annotation.dart';

// part 'get_list_article.g.dart';

@JsonSerializable(explicitToJson: true)
class GetArticleList {
  String success;
  List<GetArticleData> data;
  String? message;
  String? error;
  List<GetChainLinks> links;                      // next/previous page links
  int count;                                      // number of articles

  GetArticleList(this.success, this.data, this.message, this.error, this.links, this.count);
  factory GetArticleList.fromJson(Map<String, dynamic> json) => _$GetArticleListFromJson(json);
  Map<String, dynamic> toJson() => _$GetArticleListToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetArticleData {
  String id;                                      // article id
  String title;                                   // article title
  List<GetArticleTags> tags;                      // article tags
  @JsonKey(name : "rendered_body")
  String renderedBody;                            // article content
  String creator;
  String? banner;
  String? thumbnail;

  GetArticleData(this.id, this.title, this.tags, this.renderedBody, this.creator, this.banner, this.thumbnail);
  factory GetArticleData.fromJson(Map<String, dynamic> json) => _$GetArticleDataFromJson(json);
  Map<String, dynamic> toJson() => _$GetArticleDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetArticleTags {
  String id;
  List<GetTagsData> tags;

  GetArticleTags(this.id, this.tags);
  factory GetArticleTags.fromJson(Map<String, dynamic> json) => _$GetArticleTagsFromJson(json);
  Map<String, dynamic> toJson() => _$GetArticleTagsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetTagsData {
  String id;
  String type;
  String name;
  String? parent;
  String? icon;
  String? value;

  GetTagsData(this.id, this.type, this.name, this.value, this.parent, this.icon);
  factory GetTagsData.fromJson(Map<String, dynamic> json) => _$GetTagsDataFromJson(json);
  Map<String, dynamic> toJson() => _$GetTagsDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetChainLinks {
  String? next;
  String? previous;

  GetChainLinks(this.next, this.previous);
  factory GetChainLinks.fromJson(Map<String, dynamic> json) => _$GetChainLinksFromJson(json);
  Map<String, dynamic> toJson() => _$GetChainLinksToJson(this);
}


@JsonSerializable(explicitToJson: true)
class GetArticleId {
  String success;
  List<GetArticleData> data;
  String? message;
  String? error;

  GetArticleId(this.success, this.data, this.message, this.error);
  factory GetArticleId.fromJson(Map<String, dynamic> json) => _$GetArticleIdFromJson(json);
  Map<String, dynamic> toJson() => _$GetArticleIdToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// part of 'get_list_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetArticleList _$GetArticleListFromJson(Map<String, dynamic> json) =>
    GetArticleList(
      json['success'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => GetArticleData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['message'] as String?,
      json['error'] as String?,
      (json['links'] as List<dynamic>)
          .map((e) => GetChainLinks.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['count'] as int,
    );

Map<String, dynamic> _$GetArticleListToJson(GetArticleList instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data.map((e) => e.toJson()).toList(),
      'message': instance.message,
      'error': instance.error,
      'links': instance.links.map((e) => e.toJson()).toList(),
      'count': instance.count,
    };

GetArticleData _$GetArticleDataFromJson(Map<String, dynamic> json) =>
    GetArticleData(
      json['id'] as String,
      json['title'] as String,
      (json['tags'] as List<dynamic>)
          .map((e) => GetArticleTags.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['rendered_body'] as String,
      json['creator'] as String,
      json['banner'] as String?,
      json['thumbnail'] as String?,
    );

Map<String, dynamic> _$GetArticleDataToJson(GetArticleData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tags': instance.tags.map((e) => e.toJson()).toList(),
      'rendered_body': instance.renderedBody,
      'creator': instance.creator,
      'banner': instance.banner,
      'thumbnail': instance.thumbnail,
    };

GetArticleTags _$GetArticleTagsFromJson(Map<String, dynamic> json) =>
    GetArticleTags(
      json['id'] as String,
      (json['tags'] as List<dynamic>)
          .map((e) => GetTagsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetArticleTagsToJson(GetArticleTags instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags.map((e) => e.toJson()).toList(),
    };

GetTagsData _$GetTagsDataFromJson(Map<String, dynamic> json) => GetTagsData(
  json['id'] as String,
  json['type'] as String,
  json['name'] as String,
  json['value'] as String?,
  json['parent'] as String?,
  json['icon'] as String?,
);

Map<String, dynamic> _$GetTagsDataToJson(GetTagsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'parent': instance.parent,
      'icon': instance.icon,
      'value': instance.value,
    };

GetChainLinks _$GetChainLinksFromJson(Map<String, dynamic> json) =>
    GetChainLinks(
      json['next'] as String?,
      json['previous'] as String?,
    );

Map<String, dynamic> _$GetChainLinksToJson(GetChainLinks instance) =>
    <String, dynamic>{
      'next': instance.next,
      'previous': instance.previous,
    };


GetArticleId _$GetArticleIdFromJson(Map<String, dynamic> json) => GetArticleId(
  json['success'] as String,
  (json['data'] as List<dynamic>)
      .map((e) => GetArticleData.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['message'] as String?,
  json['error'] as String?,
);

Map<String, dynamic> _$GetArticleIdToJson(GetArticleId instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data.map((e) => e.toJson()).toList(),
      'message': instance.message,
      'error': instance.error,
    };

// Get article list
// {
//   "success": "Success",
//   "data": [
//     {
//       "id": "e30c0d41-b777-4335-918d-b3589e774e76",
//       "title": "Why breastfeed?",
//       "tags": [
//         {
//           "id": "78554c04-bfa4-4931-93d5-61b4ab59aeae",
//           "tag": {
//             "id": "8f69d168-1f3c-4543-8bea-9ad6d809b15c",
//             "type": "INTERESTS_TAG",
//             "name": "Week 1",
//             "parent": null,
//             "icon": null,
//             "value": null
//           }
//         },
//         {
//           "id": "eea4fdbf-aa2f-4edc-8834-c65809e19dd9",
//           "tag": {
//             "id": "ba0a4579-0848-4661-97ee-fe7e41bdf558",
//             "type": "INTERESTS_TAG",
//             "name": "Breastfeeding",
//             "parent": null,
//             "icon": null,
//             "value": null
//           }
//         },
//         {
//           "id": "be0a3486-03a2-47f9-971a-ddd4c4206ae4",
//           "tag": {
//             "id": "a77ba54d-8b2f-4e52-bb23-65c784b7890f",
//             "type": "INTERESTS_TAG",
//             "name": "FYI",
//             "parent": null,
//             "icon": null,
//             "value": null
//           }
//         }
//       ],
//       "rendered_body": "<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Breastfeeding is the process of feeding a baby with milk produced by the mother&apos;s breasts. It is the most natural and beneficial way to feed a baby, providing optimal nutrition and numerous health benefits for both the mother and the baby.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Breast milk is a complete and perfect food for a baby, containing all the nutrients that a baby needs to grow and develop in the first 6 months of life. It is also easy to digest and helps protect the baby from infections and illnesses.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Breastfeeding has numerous benefits for the mother as well. It can help the mother recover from childbirth more quickly, reduce the risk of certain cancers and chronic diseases, and promote bonding with the baby.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Breastfeeding is recommended by many health organizations, including the World Health Organization (WHO), the American Academy of Pediatrics (AAP), and the Centers for Disease Control and Prevention (CDC). The AAP recommends exclusive breastfeeding for the first 6 months of life, followed by continued breastfeeding with the introduction of solid foods until at least 12 months of age.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">While breastfeeding can be a natural and rewarding experience, it can also be challenging at times. It is important for new mothers to receive support and guidance from healthcare providers, lactation consultants, and family and friends to help overcome any difficulties that may arise.</span></p>",
//       "creator": "Our Psychologist",
//       "banner": null,
//       "thumbnail": null
//     },
//     {
//       "id": "d4ce85e5-38d9-440a-b32d-b2f3b3ea686d",
//       "title": "When baby refuses to breastfeed",
//       "tags": [
//         {
//           "id": "16daa68a-50b7-4ee1-86ce-560ac748a14f",
//           "tag": {
//             "id": "cbc95e1c-acd2-4650-b064-5a42513dd0e6",
//             "type": "INTERESTS_TAG",
//             "name": "Week 2",
//             "parent": null,
//             "icon": null,
//             "value": null
//           }
//         },
//         {
//           "id": "60e18212-d110-4877-9afd-5b5e326faf52",
//           "tag": {
//             "id": "ba0a4579-0848-4661-97ee-fe7e41bdf558",
//             "type": "INTERESTS_TAG",
//             "name": "Breastfeeding",
//             "parent": null,
//             "icon": null,
//             "value": null
//           }
//         },
//         {
//           "id": "23b0f1ec-967e-4837-8211-61132300c468",
//           "tag": {
//             "id": "a77ba54d-8b2f-4e52-bb23-65c784b7890f",
//             "type": "INTERESTS_TAG",
//             "name": "FYI",
//             "parent": null,
//             "icon": null,
//             "value": null
//           }
//         }
//       ],
//       "rendered_body": "<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">There are several reasons why a baby may refuse to breastfeed. Here are some common reasons and some steps you can take to encourage your baby to breastfeed:</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<ol style=\"margin-top:0;margin-bottom:0;padding-inline-start:48px;\">\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Illness or pain: If your baby is sick or in pain, they may refuse to breastfeed. Check for signs of illness, such as a fever, congestion, or a rash. If your baby is in pain, they may be more comfortable taking a bottle or pacifier. If you suspect your baby is ill or in pain, consult with your paediatrician.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Hunger cues: If your baby is not hungry, they may refuse to breastfeed. Watch for hunger cues, such as rooting or sucking on their hands, and offer the breast when they show signs of hunger.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Overstimulation: If your baby is overstimulated or overwhelmed, they may refuse to breastfeed. Try to create a calm and quiet environment for breastfeeding.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Latching issues: If your baby is having difficulty latching, they may refuse to breastfeed. Make sure that your baby is latching properly and that they are getting enough milk. You may need to seek the help of a lactation consultant to address latching issues.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Change in routine: If there has been a change in your baby&apos;s routine or environment, they may refuse to breastfeed. Try to maintain a consistent routine and environment for breastfeeding.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Teething: Teething can make breastfeeding uncomfortable for some babies, and they may refuse to breastfeed. You can offer your baby a teething toy or a cold washcloth to help alleviate discomfort.</span></p>\n    </li>\n</ol>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">If your baby refuses to breastfeed, it is important to remain patient and persistent. Keep offering the breast and try different positions or techniques to encourage your baby to latch. You can also consult with a lactation consultant or healthcare provider for additional guidance and support.</span></p>",
//       "creator": "Our Psychologist",
//       "banner": null,
//       "thumbnail": null
//     },
//     {
//       "id": "2bde1ce6-3739-401c-bcce-ce0a69584e83",
//       "title": "What to expect on the first week of breastfeeding",
//       "tags": [
//         {
//           "id": "d9d42403-e4cf-485a-80dd-7769234649ee",
//           "tag": {
//             "id": "8f69d168-1f3c-4543-8bea-9ad6d809b15c",
//             "type": "INTERESTS_TAG",
//             "name": "Week 1",
//             "parent": null,
//             "icon": null,
//             "value": null
//           }
//         },
//         {
//           "id": "3bd15f63-c12e-4014-8a3c-0ca047a0a605",
//           "tag": {
//             "id": "ba0a4579-0848-4661-97ee-fe7e41bdf558",
//             "type": "INTERESTS_TAG",
//             "name": "Breastfeeding",
//             "parent": null,
//             "icon": null,
//             "value": null
//           }
//         },
//         {
//           "id": "18ef10ad-ec72-4788-805a-58a19481d908",
//           "tag": {
//             "id": "a77ba54d-8b2f-4e52-bb23-65c784b7890f",
//             "type": "INTERESTS_TAG",
//             "name": "FYI",
//             "parent": null,
//             "icon": null,
//             "value": null
//           }
//         }
//       ],
//       "rendered_body": "<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">The first week of breastfeeding can be both exciting and challenging for new mothers. Here are some things to expect during the first week of breastfeeding:</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Frequent feedings: In the first week, babies typically breastfeed frequently, often every 1-3 hours. This is normal and helps establish a good milk supply.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Engorgement: The breasts may become full and swollen as milk comes in, usually around 2-4 days after birth. This can make breastfeeding more challenging, but it usually improves within a few days.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Sore nipples: It is common for nipples to be sore or tender during the first week of breastfeeding as the mother&apos;s body adjusts to the frequent feedings. A good latch and proper positioning can help reduce nipple pain.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Colostrum and transitional milk: In the first few days after birth, the mother&apos;s breasts produce colostrum, a thick, yellowish liquid that is high in nutrients and antibodies. Around 2-4 days after birth, the milk transitions to a more mature milk that is thinner and whiter in color.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Weight loss and gain: It is normal for babies to lose a little weight in the first few days after birth, but they should start gaining weight by the end of the first week. Your baby&apos;s healthcare provider will monitor weight gain and provide guidance if needed.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Cluster feeding: Babies may cluster feed, which means feeding frequently over a short period of time, usually in the evenings. This can be tiring for the mother, but it helps increase milk production.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Remember that breastfeeding is a learning process, and it may take some time to get the hang of it. Be patient and seek help from a lactation consultant or your healthcare provider if you have concerns or difficulties. With time and practice, breastfeeding can become a natural and enjoyable experience for both the mother and the baby.</span></p>",
//       "creator": "Our Psychologist",
//       "banner": null,
//       "thumbnail": null
//     },
//     {
//     "id": "a45e75cf-b625-4fa9-b781-693e1fa5ca23",
//     "title": "Weaning",
//     "tags": [
//     {
//     "id": "5f6dc8ee-bb6c-42ce-b965-8d59840689dd",
//     "tag": {
//     "id": "ba0a4579-0848-4661-97ee-fe7e41bdf558",
//     "type": "INTERESTS_TAG",
//     "name": "Breastfeeding",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "fbb000fc-3036-43e7-ba2c-439f7c26370f",
//     "tag": {
//     "id": "a77ba54d-8b2f-4e52-bb23-65c784b7890f",
//     "type": "INTERESTS_TAG",
//     "name": "FYI",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "debd66f1-ecc4-44f8-ba8c-273aaa7a3f78",
//     "tag": {
//     "id": "ceec1527-b3af-478e-a78e-dba60904c78b",
//     "type": "INTERESTS_TAG",
//     "name": "Week 20",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     }
//     ],
//     "rendered_body": "<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">nutrition. Here are some tips for weaning:</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<ol style=\"margin-top:0;margin-bottom:0;padding-inline-start:48px;\">\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Gradual transition: Gradually transition your baby from breastfeeding to other sources of nutrition, such as formula or solid foods. This can help reduce discomfort and prevent breast engorgement.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Follow your baby&apos;s lead: Let your baby lead the weaning process, as they may naturally lose interest in breastfeeding as they start to consume other sources of nutrition.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Introduce a cup: Introduce a cup or sippy cup to your baby to help them get used to drinking from something other than the breast.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Substitute feedings: Replace one feeding at a time with a bottle, cup, or solid food. This can help your baby get used to the new feeding routine and reduce the likelihood of engorgement.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Be patient: Weaning can be a gradual process that may take weeks or even months, so be patient and let your baby take the lead.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Offer comfort: As your baby starts to wean, offer comfort in other ways such as cuddling, rocking, or singing.</span></p>\n    </li>\n</ol>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Remember that weaning is a personal decision and the right time to start can vary for each mother and baby. It is important to make sure your baby is getting enough nutrition from other sources before completely weaning from breastmilk. Consult with a healthcare provider or lactation consultant for advice on how to approach weaning and for support throughout the process.</span></p>",
//     "creator": "Our Psychologist",
//     "banner": null,
//     "thumbnail": null
//     },
//     {
//     "id": "f1cf769b-f632-42a9-8c4d-27b327876473",
//     "title": "Tools that can help in breastfeeding",
//     "tags": [
//     {
//     "id": "5b79013f-7267-4167-b56c-b50f5769640a",
//     "tag": {
//     "id": "cbc95e1c-acd2-4650-b064-5a42513dd0e6",
//     "type": "INTERESTS_TAG",
//     "name": "Week 2",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "8696489b-3d66-4358-a16f-21de1e7dd50b",
//     "tag": {
//     "id": "ba0a4579-0848-4661-97ee-fe7e41bdf558",
//     "type": "INTERESTS_TAG",
//     "name": "Breastfeeding",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "7609606b-c359-4d3e-b251-0413a142e6f9",
//     "tag": {
//     "id": "a77ba54d-8b2f-4e52-bb23-65c784b7890f",
//     "type": "INTERESTS_TAG",
//     "name": "FYI",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     }
//     ],
//     "rendered_body": "<p><span style=\"font-size: 30px;\">Breastfeeding can be a challenging experience, especially for new mothers. Fortunately, there are tools and aids that can help make the process more comfortable and successful. Here are some tools that can be useful for breastfeeding:</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p><span style=\"font-size: 30px;\">Breast pump: A breast pump is a useful tool for mothers who need to express milk for various reasons, such as returning to work or building up a milk supply. There are manual and electric breast pumps available in the market.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p><span style=\"font-size: 30px;\">Nursing pillow: A nursing pillow can provide comfort and support to the mother and baby during breastfeeding. It can help elevate the baby to the right level, reducing the strain on the mother&apos;s arms and back.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p><span style=\"font-size: 30px;\">Nipple shields: Nipple shields are thin silicone shields that can be placed over the mother&apos;s nipple to protect sore or cracked nipples. They can also help the baby latch on correctly.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p><span style=\"font-size: 30px;\">Breast pads: Breast pads can be worn inside a bra to absorb leaking breast milk. They are especially useful during the early stages of breastfeeding when milk supply is still being established.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p><span style=\"font-size: 30px;\">Nursing bras: A nursing bra is specially designed to make breastfeeding more convenient. It has clips or flaps that allow easy access to the breast for feeding.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p><span style=\"font-size: 30px;\">Nipple cream: Nipple cream can be applied to sore or cracked nipples to soothe and heal them.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p><span style=\"font-size: 30px;\">Lactation consultant: A lactation consultant is a trained professional who can provide guidance and support on breastfeeding. They can help mothers overcome breastfeeding challenges and ensure a successful and comfortable breastfeeding experience.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p><span style=\"font-size: 30px;\">These tools can help mothers in their breastfeeding journey. However, it is essential to consult with a healthcare provider or lactation consultant before using any tools to ensure their safety and effectiveness.</span></p>",
//     "creator": "Our Psychologist",
//     "banner": null,
//     "thumbnail": null
//     },
//     {
//     "id": "41a50f52-cc21-4f84-8f0c-e9996dbf4386",
//     "title": "Sore nipples",
//     "tags": [
//     {
//     "id": "99ded7ea-0c6d-4702-bcb4-685d243392af",
//     "tag": {
//     "id": "cbc95e1c-acd2-4650-b064-5a42513dd0e6",
//     "type": "INTERESTS_TAG",
//     "name": "Week 2",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "86bd9597-54e4-4bfc-ba94-ae86ae0c0af8",
//     "tag": {
//     "id": "ba0a4579-0848-4661-97ee-fe7e41bdf558",
//     "type": "INTERESTS_TAG",
//     "name": "Breastfeeding",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "d9a3151c-d262-43a8-9ff1-461729e34e2b",
//     "tag": {
//     "id": "a77ba54d-8b2f-4e52-bb23-65c784b7890f",
//     "type": "INTERESTS_TAG",
//     "name": "FYI",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     }
//     ],
//     "rendered_body": "<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Sore nipples are a common problem for breastfeeding mothers, especially in the first few weeks of breastfeeding. Here are some tips to help prevent and treat sore nipples:</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<ol style=\"margin-top:0;margin-bottom:0;padding-inline-start:48px;\">\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Ensure proper latch: Make sure that your baby is latching properly, with their mouth wide open and taking in as much of the areola as possible. A shallow latch can cause nipple pain and damage.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Vary breastfeeding positions: Changing up breastfeeding positions can help prevent sore nipples by putting pressure on different areas of the breast.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Check for tongue or lip ties: If your baby is having difficulty latching properly, they may have a tongue or lip tie that can cause nipple pain. Consult with a lactation consultant or healthcare provider for evaluation and treatment.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Moisturize nipples: Use a lanolin-based cream or other nipple balm to moisturize and soothe sore nipples.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Air out nipples: Exposing nipples to air can help prevent and treat soreness.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Use nipple shields: Nipple shields can help reduce friction and provide a protective barrier for sore nipples.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Take a break: If your nipples are very sore, take a break from breastfeeding and use a breast pump or hand expression to express milk instead.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Pain relief: Over-the-counter pain relievers such as ibuprofen or acetaminophen can help reduce nipple pain.</span></p>\n    </li>\n</ol>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Remember that some nipple soreness in the early days of breastfeeding is normal, but if the pain is severe, persistent, or accompanied by other symptoms such as cracking or bleeding, consult with a lactation consultant or healthcare provider for further evaluation and treatment.</span></p>",
//     "creator": "Our Psychologist",
//     "banner": null,
//     "thumbnail": null
//     },
//     {
//     "id": "e2c67f52-e7aa-44e0-bde4-19dec5a58069",
//     "title": "Skin to skin while breastfeeding",
//     "tags": [
//     {
//     "id": "5dc5d22b-589e-4783-84b1-b6b40d6e687e",
//     "tag": {
//     "id": "8f69d168-1f3c-4543-8bea-9ad6d809b15c",
//     "type": "INTERESTS_TAG",
//     "name": "Week 1",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "5b5b3da4-a07c-4930-9e77-9fa6a4a05c98",
//     "tag": {
//     "id": "cbc95e1c-acd2-4650-b064-5a42513dd0e6",
//     "type": "INTERESTS_TAG",
//     "name": "Week 2",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "30bf8c2e-4332-4782-833a-293eb8f59c3e",
//     "tag": {
//     "id": "f1e0b34f-6beb-4bca-aa67-ab290f211d82",
//     "type": "INTERESTS_TAG",
//     "name": "Week 3",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "d26036e3-46b8-4840-a4d7-a6396a5f241f",
//     "tag": {
//     "id": "ba0a4579-0848-4661-97ee-fe7e41bdf558",
//     "type": "INTERESTS_TAG",
//     "name": "Breastfeeding",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "6bbdde38-2f12-44ba-b09e-1eebdea0bcff",
//     "tag": {
//     "id": "a77ba54d-8b2f-4e52-bb23-65c784b7890f",
//     "type": "INTERESTS_TAG",
//     "name": "FYI",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     }
//     ],
//     "rendered_body": "<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(0, 0, 0); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Skin-to-skin contact, also known as kangaroo care, is a practice that involves placing a newborn baby on their mother&apos;s bare chest. It has many benefits for both the mother and baby, including during breastfeeding.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(0, 0, 0); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Skin-to-skin contact can help to stimulate milk production and promote the release of the hormone oxytocin, which helps with milk let-down. It can also help the baby to regulate their body temperature, breathing, and heart rate. Skin-to-skin contact can also promote bonding between the mother and baby, which is crucial for a successful breastfeeding relationship.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(0, 0, 0); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">When a mother breastfeeds her baby skin-to-skin, it can create a calming environment that helps the baby to relax and feel comfortable. It can also help the mother to be more in tune with her baby&apos;s feeding cues and promote a successful latch.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(0, 0, 0); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Skin-to-skin contact can be done immediately after birth and during the first few weeks of life. It is recommended to have uninterrupted skin-to-skin contact for at least the first hour after birth, and then as often as possible throughout the day.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(0, 0, 0); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">If a mother is unable to breastfeed for any reason, skin-to-skin contact can still be beneficial for the baby. It can help the baby to feel more secure and calm, which is essential for their overall well-being.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(0, 0, 0); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">In summary, skin-to-skin contact can be a powerful tool to support successful breastfeeding. It can help to promote bonding, milk production, and a successful latch. It is recommended to incorporate skin-to-skin contact as much as possible in the early days of a baby&apos;s life, whether or not the mother is breastfeeding.</span></p>",
//     "creator": "Our Psychologist",
//     "banner": null,
//     "thumbnail": null
//     },
//     {
//     "id": "7c8cf963-3de5-4a6c-bb37-971731cd55ab",
//     "title": "Reading your baby's feeding cues",
//     "tags": [
//     {
//     "id": "cdac5ac5-a171-4545-be0f-57e584d8bbbf",
//     "tag": {
//     "id": "8f69d168-1f3c-4543-8bea-9ad6d809b15c",
//     "type": "INTERESTS_TAG",
//     "name": "Week 1",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "f2f02f29-78f6-472e-86fd-3d92d5e22c0d",
//     "tag": {
//     "id": "cbc95e1c-acd2-4650-b064-5a42513dd0e6",
//     "type": "INTERESTS_TAG",
//     "name": "Week 2",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "dd445834-acaf-40bb-acf9-13b0a29e2184",
//     "tag": {
//     "id": "f1e0b34f-6beb-4bca-aa67-ab290f211d82",
//     "type": "INTERESTS_TAG",
//     "name": "Week 3",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "4e714d57-7f5e-4996-8ff5-cdc2374376ce",
//     "tag": {
//     "id": "ba0a4579-0848-4661-97ee-fe7e41bdf558",
//     "type": "INTERESTS_TAG",
//     "name": "Breastfeeding",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "461f8566-3551-4c88-9fdd-e3bf3f0a8021",
//     "tag": {
//     "id": "a77ba54d-8b2f-4e52-bb23-65c784b7890f",
//     "type": "INTERESTS_TAG",
//     "name": "FYI",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     }
//     ],
//     "rendered_body": "<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Reading your baby&apos;s feeding cues is important to ensure that your baby is well-fed and satisfied. Here are some common feeding cues to look out for:</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<ol style=\"margin-top:0;margin-bottom:0;padding-inline-start:48px;\">\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Rooting reflex: When your baby is hungry, they will turn their head toward your breast, open their mouth, and start to search for the nipple.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Sucking motions: Your baby may start to make sucking motions with their mouth or tongue.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Hand-to-mouth movements: Your baby may bring their hands to their mouth and suck on their fingers or hands.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Fussing or crying: Your baby may start to fuss or cry when they are hungry, especially if they are not fed promptly.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Smacking or licking lips: Your baby may smack their lips or lick their lips when they are hungry.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Squirming or fidgeting: Your baby may start to squirm or fidget when they are hungry, especially if they are uncomfortable.</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: decimal; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Changes in facial expression: Your baby may make facial expressions, such as puckering their lips or opening their mouth wide, when they are hungry.</span></p>\n    </li>\n</ol>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">It is important to respond promptly to your baby&apos;s feeding cues to ensure that they are well-fed and satisfied. This can also help establish a good breastfeeding relationship and promote bonding between you and your baby. If you are unsure about whether your baby is hungry, try offering the breast or a bottle and see if they show signs of being interested in feeding. As you spend more time with your baby, you will become more attuned to their feeding cues and be able to respond to their needs more easily.</span></p>",
//     "creator": "Our Psychologist",
//     "banner": null,
//     "thumbnail": null
//     },
//     {
//     "id": "c2bb86cd-3f61-497b-8a91-a88c3eacbf1f",
//     "title": "Pumping",
//     "tags": [
//     {
//     "id": "19aee523-c7e0-4ff8-954d-50df8cf5688b",
//     "tag": {
//     "id": "8f69d168-1f3c-4543-8bea-9ad6d809b15c",
//     "type": "INTERESTS_TAG",
//     "name": "Week 1",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "e6c07f80-aa16-4c2c-b927-5485a79aa032",
//     "tag": {
//     "id": "cbc95e1c-acd2-4650-b064-5a42513dd0e6",
//     "type": "INTERESTS_TAG",
//     "name": "Week 2",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "b8e2a66f-329f-40dd-bd57-d2cb03194929",
//     "tag": {
//     "id": "f1e0b34f-6beb-4bca-aa67-ab290f211d82",
//     "type": "INTERESTS_TAG",
//     "name": "Week 3",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "afa0fddc-c7a2-4197-b5bf-1b765966c363",
//     "tag": {
//     "id": "9b7bdec1-53f5-45c9-b6d4-a1ae5178635b",
//     "type": "INTERESTS_TAG",
//     "name": "Week 4",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "d055eeb4-7e7c-4043-b2ea-00ee0e8669de",
//     "tag": {
//     "id": "ba0a4579-0848-4661-97ee-fe7e41bdf558",
//     "type": "INTERESTS_TAG",
//     "name": "Breastfeeding",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "945b4130-e27b-44d4-80ee-737f0b7f09f3",
//     "tag": {
//     "id": "86a9c138-60b9-4f4e-9921-afd6cdc2b1c5",
//     "type": "INTERESTS_TAG",
//     "name": "Pumping",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "ddaa1a26-8814-4bb5-8c6a-001eef552ddb",
//     "tag": {
//     "id": "a77ba54d-8b2f-4e52-bb23-65c784b7890f",
//     "type": "INTERESTS_TAG",
//     "name": "FYI",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "3574f6cd-f8af-428b-9b1e-40a54582e1ad",
//     "tag": {
//     "id": "d960e0ad-c883-4735-9735-132fe28183e4",
//     "type": "INTERESTS_TAG",
//     "name": "Week 9",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "57efb72e-f203-4873-ae67-31de4b9d9bf8",
//     "tag": {
//     "id": "c16a4390-4b11-445e-9000-72cd36473e5f",
//     "type": "INTERESTS_TAG",
//     "name": "Week 10",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "439555fa-be73-4c60-a603-b88feadc4e93",
//     "tag": {
//     "id": "f9184b03-2bd2-4dbb-baec-8c9629717ac8",
//     "type": "INTERESTS_TAG",
//     "name": "Week 11",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "cbdcbc8a-c96e-47ac-875f-d2aba9f91f0b",
//     "tag": {
//     "id": "93c5bfc9-ce29-44fa-ad2d-4b8649be7ba9",
//     "type": "INTERESTS_TAG",
//     "name": "Week 12",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     }
//     ],
//     "rendered_body": "<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(55, 65, 81); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Pumping is the process of using a breast pump to express breast milk. Pumping can be done for a variety of reasons, including:</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<ul style=\"margin-top:0;margin-bottom:0;padding-inline-start:48px;\">\n    <li dir=\"ltr\" style=\"list-style-type: disc; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(55, 65, 81); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(55, 65, 81); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">To provide breast milk for the baby when the mother is unable to breastfeed directly</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: disc; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(55, 65, 81); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(55, 65, 81); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">To relieve engorgement or discomfort in the breasts</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: disc; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(55, 65, 81); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(55, 65, 81); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">To increase milk supply</span></p>\n    </li>\n    <li dir=\"ltr\" style=\"list-style-type: disc; font-size: 30px; font-family: Roboto, sans-serif; color: rgb(55, 65, 81); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre;\" aria-level=\"1\">\n        <p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-family: Roboto, sans-serif; color: rgb(55, 65, 81); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">To allow the mother to store breast milk for future use</span></p>\n    </li>\n</ul>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(55, 65, 81); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Pumping can be done using a manual or electric breast pump, and the expressed milk can be stored in a container and used for bottle feeding. Some mothers choose to exclusively pump and feed their babies with expressed milk, while others use a combination of breastfeeding and bottle feeding with pumped milk.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(55, 65, 81); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">It is important to follow safe practices for both bottle feeding and pumping, such as using clean equipment and properly storing breast milk. It is also important to seek support from a healthcare provider or lactation consultant if you have any questions or concerns about feeding your baby.</span></p>",
//     "creator": "Our Psychologist",
//     "banner": null,
//     "thumbnail": null
//     },
//     {
//     "id": "71859f24-59ce-4113-bdb7-a849a1798ba8",
//     "title": "Power Pumping",
//     "tags": [
//     {
//     "id": "7760c8a7-f40f-48a5-961f-9ec3dfdaa337",
//     "tag": {
//     "id": "8f69d168-1f3c-4543-8bea-9ad6d809b15c",
//     "type": "INTERESTS_TAG",
//     "name": "Week 1",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "556981d1-35e5-4f71-b1d5-5df7c2b716de",
//     "tag": {
//     "id": "cbc95e1c-acd2-4650-b064-5a42513dd0e6",
//     "type": "INTERESTS_TAG",
//     "name": "Week 2",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "48be66a4-ebec-43d6-84dc-4b5160231939",
//     "tag": {
//     "id": "f1e0b34f-6beb-4bca-aa67-ab290f211d82",
//     "type": "INTERESTS_TAG",
//     "name": "Week 3",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "e5a22a7f-f525-40d4-8f3e-2dc0de7fae1d",
//     "tag": {
//     "id": "9b7bdec1-53f5-45c9-b6d4-a1ae5178635b",
//     "type": "INTERESTS_TAG",
//     "name": "Week 4",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "3be87a1d-3e09-4fa5-98d0-38f5b9924cc0",
//     "tag": {
//     "id": "ba0a4579-0848-4661-97ee-fe7e41bdf558",
//     "type": "INTERESTS_TAG",
//     "name": "Breastfeeding",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "2a64820f-5a44-463a-b965-3363e2427d97",
//     "tag": {
//     "id": "86a9c138-60b9-4f4e-9921-afd6cdc2b1c5",
//     "type": "INTERESTS_TAG",
//     "name": "Pumping",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     },
//     {
//     "id": "d8ab46f4-e439-4e86-87a4-62614e21c65d",
//     "tag": {
//     "id": "a4687ded-9cab-445b-86e3-6cf3e52ee2ce",
//     "type": "INTERESTS_TAG",
//     "name": "Tips",
//     "parent": null,
//     "icon": null,
//     "value": null
//     }
//     }
//     ],
//     "rendered_body": "<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Power pumping is a technique used to increase milk supply by stimulating milk production. The technique involves pumping breast milk for a specific period of time, typically 10-20 minutes, followed by a rest period, and then repeating the process for a total of 60-90 minutes. The goal is to mimic a baby&apos;s cluster feeding, which can help to increase milk production.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Here are the steps to power pumping:</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Choose a time when you can pump without interruption for an hour.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Pump for 20 minutes.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Rest for 10 minutes.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Pump for another 10 minutes.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Rest for another 10 minutes.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Pump for a final 10 minutes.</span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Repeat this process once a day for several days in a row.</span></p>\n<p><span style=\"font-size: 30px;\"><br></span></p>\n<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size: 30px; font-family: Roboto, sans-serif; color: rgb(89, 89, 89); background-color: transparent; font-weight: 400; font-style: normal; font-variant: normal; text-decoration: none; vertical-align: baseline; white-space: pre-wrap;\">Power pumping can be effective in increasing milk supply, but it&apos;s important to keep in mind that it may take a few days or even weeks to see results. Additionally, it&apos;s important to ensure that you&apos;re using the correct pump settings and flange size to maximize milk removal and minimize discomfort. If you have any concerns about your milk supply or your pumping routine, it&apos;s always a good idea to speak with a lactation consultant for personalized guidance and support.</span></p>",
//     "creator": "Our Psychologist",
//     "banner": null,
//     "thumbnail": null
//     }
//   ],
//   "message": null,
//   "error": null,
//   "links": {
//   "next": "http://54.169.131.201:8000/api/v1/article/list?page=2&page_size=10&search=",
//   "previous": null
//   },
//   "count": 85
// }

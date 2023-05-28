import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as milliseconds;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../../../constant/variables.dart';
import '../../../../services/dio_services.dart';
import '../../login/controllers/login_controller.dart';
import '../model/create_article_data.dart';


class AdminClient {
  final Dio _dio = Dio();
  late String accessToken;

  Dio init() {
    // Dio _dio = Dio();
    // _dio.interceptors.add(toBeDefined());
    accessToken = authToken;
    // For refreshToken test
    // accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkZW50aWZpZXIiOiJmNTA0M2Q1OS1hY2QxLTQ5MmUtODAzOC0wZmUwMDMwNmYwNTEiLCJleHAiOjE2ODQ1NzIzMzEsImlhdCI6MTY4NDU2ODczMS40NDU0OTQsInNjb3BlIjoiQUNDRVNTIiwidXNlcm5hbWUiOiJhZG1pbl9oZXl2YSIsImVtYWlsIjpudWxsLCJwaG9uZV9udW1iZXIiOm51bGwsInByb2ZpbGVfY29kZSI6IjIwMjMwMzE2MDAwMDAwMTYiLCJyb2xlcyI6WyI3NjM5ZWI4OS01Yzc2LTQwMjgtYTliZi03MGQwMDA4ZjcxNGUiLCJlZjM2MmRhZS02NTc5LTQzOGYtYTA5OS0xNDhkZWRmYzI2YjAiXX0.XY3AAO6kvuyI3V_LRi1QV_nKhNcYWe2prPAFlIZWZVk";
    _dio.options = BaseOptions(
      baseUrl: heyApiBaseUrl,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      connectTimeout: 5000.milliseconds,
      receiveTimeout: 3000.milliseconds,
    );
    return _dio;
  }
  refreshOption() {
    accessToken = authToken;
    _dio.options = BaseOptions(
      baseUrl: heyApiBaseUrl,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      connectTimeout: 5000.milliseconds,
      receiveTimeout: 3000.milliseconds,
    );
  }
}

class CreateProvider {
  final Dio _createClient;
  CreateProvider(this._createClient);

  Future<AttArticleModel?> postNewAttachment({required Uint8List bytes, required String fileName}) async {
    AttArticleModel? resp;

    try {
      FormData formData = FormData.fromMap({
        "attachment":
        MultipartFile.fromBytes(bytes, filename: fileName),
      });
      Response response = await _createClient.post("/api/v1/article-attachment/create", data: formData);
      resp = AttArticleModel.fromJson(response.data);
      // debugPrint('Article id: ${resp.data?.id}');

    } on DioError catch (err) {
      debugPrint('POST fail with result: ${err.response?.statusCode}');
      var message = err.response?.data['message'];
      var error = err.response?.data['error'];
      // in case of message of error is 'Expired Signature' then will retry getNewId() after refresh the authToken
      resp = AttArticleModel(success: "", data: null, message: message, error: error);
    }

    return resp;
  }

  Future<PostArticleModel?> postNewArticle({
    required String artId,
    required String title,
    required String body,
    required String tag,
  }) async {
    PostArticleModel? resp;

    try {
      FormData formData = FormData.fromMap({
        "title": title,
        "body": body,
        "tag": tagsList[tag],
        "attachment": artId,
        "creator": "Heyva",
      });
      Response response = await _createClient.post("/api/v1/article/create", data: formData);
      resp = PostArticleModel.fromJson(response.data);

    } on DioError catch (err) {
      debugPrint('POST fail with result: ${err.response?.statusCode}');
      var message = err.response?.data['message'];
      var error = err.response?.data['error'];
      // in case of message of error is 'Expired Signature' then will retry postNewAttachment() after refresh the authToken
      resp = PostArticleModel(success: "", data: null, message: message, error: error);
    }

    return resp;
  }

  Future<TagsArticleModel?> getArticleTags() async {
    TagsArticleModel? resp;

    try {
      FormData formData = FormData.fromMap({
      });
      Response response = await _createClient.get(
        // "/api/v1/dictionary/get-by-type?type=INTERESTS_TAG&search="
        "/api/v1/dictionary/get-by-type?",
        queryParameters: {'type': 'INTERESTS_TAG', 'search': ''}
      );
      resp = TagsArticleModel.fromJson(response.data);
      debugPrint('Get Tags: ${resp.success}');

    } on DioError catch (err) {
      debugPrint('POST fail with result: ${err.response?.statusCode}');
      var message = err.response?.data['message'];
      var error = err.response?.data['error'];
      // in case of message of error is 'Expired Signature' then will retry getNewId() after refresh the authToken
      resp = TagsArticleModel(success: "", data: null, message: message, error: error);
    }

    return resp;
  }
}

class CreateController extends GetxController {

  late AdminClient _client;
  late CreateProvider _create;

  @override
  void onInit() {
    _client = AdminClient();
    _create = CreateProvider(_client.init());
    super.onInit();
  }
  final accessCtrl = Get.find<LoginController>();
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();
  final TextEditingController categoryCtrl = TextEditingController();
  final TextEditingController htmlCtrl = TextEditingController();

  var isPostingImage = false;
  var isPostingArticle = false;
  var isGettingTags = false;
  bool isSelectedImage = false;
  var errorPostMessage = ''.obs;
  var gotAttachmentId = false.obs;
  var gotPostingId = false.obs;
  var gotTagsList = false.obs;
  var attachmentId = ''.obs;
  var articleId = ''.obs;
  late String artTitle;
  late String artTopic;
  late DateTime postDate;
  String imageFileName = '';
  String htmlFileName = '';
  var imageBytes = Uint8List(0).obs;
  var htmlBytes = Uint8List(0).obs;
  List<String> tagsList = [];
  late List<dynamic> articleTags;
  late List<String?> tagsId;
  late List<String?> tagNames;

  var getIdResponse =
      AttArticleModel(success: "", data: null, message: "", error: "").obs;

  getAttachmentId() async {

    if(isSelectedImage) {
      errorPostMessage.value = '';
      isPostingImage = true;
        try {
          getIdResponse.value = (await _create.postNewAttachment(bytes: imageBytes.value, fileName: imageFileName))!;
          isPostingImage = false;
          if(getIdResponse.value.success == 'Success') {
            attachmentId.value = getIdResponse.value.data!.id!;
            if(attachmentId.isNotEmpty) {
              gotAttachmentId.value = true;
            }
          } else {
            // in case of message of error is 'Expired Signature' then call tokenRefresh and retry
            if(getIdResponse.value.message == 'Expired Signature') {
              accessCtrl.tokenRefresh();
              _client.refreshOption();
              isPostingImage = true;
              try {
                getIdResponse.value = (await _create.postNewAttachment(bytes: imageBytes.value, fileName: imageFileName))!;
                isPostingImage = false;
                if(getIdResponse.value.success == 'Success') {
                  attachmentId.value = getIdResponse.value.data!.id!;
                  if (attachmentId.isNotEmpty) {
                    gotAttachmentId.value = true;
                  }
                } else {
                  debugPrint('Bad access token signature and \nfailed to get attachment id: ${getIdResponse.value.message} !');
                }
              } catch (err) {
                isPostingImage = false;
                debugPrint("error  $err");
              }
            }
          }
        } catch (err) {
          isPostingImage = false;
          debugPrint("error  $err");
        }
    } else {
      debugPrint('Select a picture file first !');
    }
  }

  var postArticleResponse =
      PostArticleModel(success: "", data: null, message: "", error: "").obs;

  Future<String> postCreateArticle(String id) async {

    if(isSubmitReady()) {
      if (id == attachmentId.value) {
        errorPostMessage.value = '';
        isPostingArticle = true;

        try {
          postArticleResponse.value = (await _create.postNewArticle(
            artId: id,
            title: titleCtrl.value.text,
            body: htmlCtrl.value.text,
            tag: "new born",
          ))!;
          isPostingArticle = false;
          articleId.value = postArticleResponse.value.data!.id!;
          if(articleId.isNotEmpty) {
            gotPostingId.value = true;
          }
          return articleId.value;
        } catch (err) {
          isPostingImage = false;
          debugPrint("error  $err");
          return '';
        }
      } else {
        debugPrint('Article invalid !');
        return '';
      }
    } else {
      debugPrint('Article not ready to submit yet !');
      return '';
    }
  }

  var getTagsResponse =
      TagsArticleModel(success: "", data: null, message: "", error: "").obs;

  Future<List<String?>> getArticleTagsList() async {

    errorPostMessage.value = '';
    isGettingTags = true;
    debugPrint('Test getting article tags list !');

    try {
      getTagsResponse.value = (await _create.getArticleTags())!;
      isGettingTags = false;
      debugPrint('Test getting article tags list ... ${getTagsResponse.value.success} !');
      articleTags = getTagsResponse.value.data?.toList() as List<dynamic>;
      // later will map<tagNames, tagsId) for selecting tagId based on selected tagName for posting article parameters
      tagsId = getTagsResponse.value.data!.map((e) => e.id).toList();
      tagNames = getTagsResponse.value.data!.map((e) => e.name).toList();
      return tagNames;
    } catch (err) {
      isGettingTags = false;
      debugPrint("error  $err");
      return ['Error dio.get !'];
    }
  }

  Future<String> selectImage() async {
    imageFileName = '';
    final mediaInfo = await ImagePickerWeb.getImageInfo;
    final data = mediaInfo?.data;

    if (data != null) {
      imageBytes.value = data;
      imageFileName = mediaInfo!.fileName!;
      isSelectedImage = true;
    }
    return imageFileName;
  }

  void getImageBytes(Uint8List data) {
    data = imageBytes.value;
  }

  void clearPhotoAndId() {
    attachmentId.value = '';
    gotAttachmentId.value = false;
    imageFileName = '';
    imageBytes.value = Uint8List(0);
    isSelectedImage = false;
  }

  Future<String?> uploadHtml() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.custom,
        allowedExtensions: ['txt', 'html']);
    htmlBytes.value = Uint8List(0);
    if (result != null) {
      PlatformFile file = result.files.first;
      htmlBytes.value = file.bytes!;
      htmlFileName = file.name;
      htmlCtrl.text = "";
      for(var i=0 ; i < htmlBytes.value.buffer.asByteData().lengthInBytes; i++) {
        htmlCtrl.text = htmlCtrl.text + String.fromCharCode(htmlBytes.value.buffer.asByteData().getUint8(i));
      }

    } else {
      // User canceled the picker
      return '';
    }
    return htmlFileName;
  }

  bool isSubmitReady() {
    return (
      attachmentId.value.isNotEmpty &&
      titleCtrl.value.text.isNotEmpty &&
      dateCtrl.value.text.isNotEmpty &&
      categoryCtrl.value.text.isNotEmpty &&
      htmlCtrl.value.text.isNotEmpty
    );
  }

  clearCreatePage() {
    if(gotPostingId.value) {
      imageFileName = '';
      htmlFileName = '';
      attachmentId.value = '';
      articleId.value = '';
      isSelectedImage = false;
      gotAttachmentId.value = false;
      titleCtrl.clear();
      categoryCtrl.clear();
      dateCtrl.clear();
      htmlCtrl.clear();
      imageBytes.value = Uint8List(0);
      htmlBytes.value = Uint8List(0);
    } else {
      debugPrint('Posting article is not done yet !');
    }
  }
}

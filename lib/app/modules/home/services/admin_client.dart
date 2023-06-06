import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as milliseconds;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
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

  Future<AttArticleModel?> postNewAttachment({required Uint8List bytes, required String fileName, required String mode}) async {
    AttArticleModel? resp;

    try {
      FormData formData = FormData.fromMap({
        "attachment": MultipartFile.fromBytes(bytes, filename: fileName),
        "app_env": mode,
      });
      Response response = await _createClient.post("/api/v1/article-attachment/create", data: formData);
      resp = AttArticleModel.fromJson(response.data);

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
    required List<String> tagsId,
    required String mode,
  }) async {
    PostArticleModel? resp;

    try {
      FormData formData = FormData.fromMap({
        "title": title,
        "body": body,
        "attachment": artId,
        "creator": "Heyva",
      });
      for(int i=0 ; i < tagsId.length ; i++) {
        formData.fields.add(MapEntry("tag", tagsId[i]));
      }
      formData.fields.add(MapEntry("app_env", mode));
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
        "/api/v1/dictionary/get-by-type?",
        queryParameters: {'type': 'INTERESTS_TAG', 'search': ''}
      );
      resp = TagsArticleModel.fromJson(response.data);

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
  final TextEditingController htmlCtrl = TextEditingController();

  var isPostingArticle = false;
  var isGettingTags = false;
  bool isSelectedImage = false;
  var errorPostMessage = ''.obs;
  var gotAttachmentId = false.obs;
  var gotPostingId = false.obs;
  var gotTagsList = false.obs;
  var attachmentId = ''.obs;
  var articleId = ''.obs;
  var isPostingReady = false.obs;
  late String artTitle;
  late String artTopic;
  late DateTime postDate;
  String imageFileName = '';
  String htmlFileName = '';
  var imageBytes = Uint8List(0).obs;
  var htmlBytes = Uint8List(0).obs;
  List<TagsData>? fullTags = [];
  List<TagIdName> tagIdNames = [];
  var selectedTags = <TagIdName?>[].obs;
  var items = <MultiSelectItem<TagIdName>>[].obs;
  List<String> selectedTagsId = [];
  var selectedMode = ''.obs;


  var getIdResponse =
      AttArticleModel(success: "", data: null, message: "", error: "").obs;

  getAttachmentId() async {

    if(isSelectedImage) {
      errorPostMessage.value = '';
        try {
          getIdResponse.value = (await _create.postNewAttachment(
            bytes: imageBytes.value,
            fileName: imageFileName,
            mode: selectedMode.value.toLowerCase()
          ))!;
          if(getIdResponse.value.success == 'Success') {
            attachmentId.value = getIdResponse.value.data!.id!;
            if(attachmentId.isNotEmpty) {
              gotAttachmentId.value = true;
              updateReadiness();
            }
          } else {
            // in case of message of error is 'Expired Signature' then call tokenRefresh and retry
            if(getIdResponse.value.message == 'Expired Signature') {
              accessCtrl.tokenRefresh();
              _client.refreshOption();
              try {
                getIdResponse.value = (await _create.postNewAttachment(
                  bytes: imageBytes.value,
                  fileName: imageFileName,
                  mode: selectedMode.value.toLowerCase()
                ))!;
                if(getIdResponse.value.success == 'Success') {
                  attachmentId.value = getIdResponse.value.data!.id!;
                  if (attachmentId.isNotEmpty) {
                    gotAttachmentId.value = true;
                    updateReadiness();
                  }
                } else {
                  debugPrint('Bad access token signature and \nfailed to get attachment id: ${getIdResponse.value.message} !');
                }
              } catch (err) {
                debugPrint("error  $err");
              }
            }
          }
        } catch (err) {
          debugPrint("error  $err");
        }
    } else {
      debugPrint('Select a picture file first !');
    }
  }

  var postArticleResponse =
      PostArticleModel(success: "", data: null, message: "", error: "").obs;

  Future<String> postCreateArticle(String id) async {

    if (id == attachmentId.value) {
      errorPostMessage.value = '';
      isPostingArticle = true;

      try {
        postArticleResponse.value = (await _create.postNewArticle(
          artId: id,
          title: titleCtrl.value.text,
          body: htmlCtrl.value.text,
          tagsId: selectedTagsId,
          mode: selectedMode.value.toLowerCase()
        ))!;
        isPostingArticle = false;
        articleId.value = postArticleResponse.value.data!.id!;
        if(articleId.isNotEmpty) {
          gotPostingId.value = true;
          updateReadiness();
        }
        return articleId.value;
      } catch (err) {
        isPostingArticle = false;
        debugPrint("error  $err");
        // in case of message of error is 'Expired Signature' then call tokenRefresh and retry
        if(getIdResponse.value.message == 'Expired Signature') {
          accessCtrl.tokenRefresh();
          _client.refreshOption();
          try {
            postArticleResponse.value = (await _create.postNewArticle(
              artId: id,
              title: titleCtrl.value.text,
              body: htmlCtrl.value.text,
              tagsId: selectedTagsId,
              mode: selectedMode.value.toLowerCase()
            ))!;
            isPostingArticle = false;
            articleId.value = postArticleResponse.value.data!.id!;
            if(articleId.isNotEmpty) {
              gotPostingId.value = true;
              updateReadiness();
            }
            return articleId.value;
          } catch (err) {
            isPostingArticle = false;
            debugPrint("error  $err");
          }
        }
        return '';
      }
    } else {
      debugPrint('Article invalid !');
      return '';
    }
  }

  var getTagsResponse =
      TagsArticleModel(success: "", data: null, message: "", error: "").obs;

  Future<List<TagIdName>?> initArticleTagsList() async {

    errorPostMessage.value = '';
    isGettingTags = true;

    try {
      getTagsResponse.value = (await _create.getArticleTags())!;
      isGettingTags = false;
      fullTags = getTagsResponse.value.data?.toList();
      tagIdNames = fullTags!.map((e) => (TagIdName(id: e.id!, name: e.name!))).toList();
      items.value = tagIdNames!.map((tag) => MultiSelectItem<TagIdName>(tag, tag.name)).toList();
      gotTagsList.value = true;
      updateReadiness();
      return tagIdNames;
    } catch (err) {
      isGettingTags = false;
      debugPrint("error  $err");
      // in case of message of error is 'Expired Signature' then call tokenRefresh and retry
      if(getIdResponse.value.message == 'Expired Signature') {
        accessCtrl.tokenRefresh();
        _client.refreshOption();
        try {
          getTagsResponse.value = (await _create.getArticleTags())!;
          isGettingTags = false;
          fullTags = getTagsResponse.value.data?.toList();
          tagIdNames = fullTags!.map((e) => (TagIdName(id: e.id!, name: e.name!))).toList();
          items.value = tagIdNames!.map((tag) => MultiSelectItem<TagIdName>(tag, tag.name)).toList();
          gotTagsList.value = true;
          updateReadiness();
          return tagIdNames;
        } catch (err) {
          isGettingTags = false;
          debugPrint("error  $err");
        }
      }
      return null;
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
      updateReadiness();
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
      updateReadiness();
    } else {
      // User canceled the picker
      return '';
    }
    return htmlFileName;
  }

  bool updateReadiness() {

    if(
      titleCtrl.text.isNotEmpty &&
      dateCtrl.text.isNotEmpty &&
      htmlCtrl.text.isNotEmpty &&
      attachmentId.value.isNotEmpty &&
      titleCtrl.value.text.isNotEmpty &&
      dateCtrl.value.text.isNotEmpty &&
      selectedTagsId.isNotEmpty &&
      htmlCtrl.value.text.isNotEmpty
    ) {
      isPostingReady.value = true;
    }
    return isPostingReady.value;
  }

  clearCreatePage() {
    if(gotPostingId.value) {
      selectedMode.value = '';
      imageFileName = '';
      htmlFileName = '';
      attachmentId.value = '';
      articleId.value = '';
      isSelectedImage = false;
      gotAttachmentId.value = false;
      titleCtrl.clear();
      dateCtrl.clear();
      htmlCtrl.clear();
      imageBytes.value = Uint8List(0);
      htmlBytes.value = Uint8List(0);
      gotTagsList.value = false;
      selectedTags.value.removeRange(0, selectedTagsId.length);
      selectedTagsId.clear();
      gotPostingId.value = false;
      isPostingReady.value = false;
    } else {
      debugPrint('Posting article is not done yet !');
    }
  }

  updateSelectedTagsId() {
    selectedTagsId = selectedTags.value.map((e) => e!.id).toList();
    updateReadiness();
  }
}

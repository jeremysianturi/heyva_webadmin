import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as milliseconds;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../../../constant/variables.dart';
import '../../../../services/dio_services.dart';
import '../model/create_article_data.dart';


class AdminClient {
  Dio init() {
    Dio _dio = Dio();
    // _dio.interceptors.add(toBeDefined());
    _dio.options = BaseOptions(
      baseUrl: heyApiBaseUrl,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      connectTimeout: 5000.milliseconds,
      receiveTimeout: 3000.milliseconds,
    );
    return _dio;
  }
}

class CreateProvider {
  final Dio _createClient;
  CreateProvider(this._createClient);

  Future<CreateModel?> getNewId({required Uint8List bytes, required String fileName}) async {
    CreateModel? resp;

    try {
      FormData formData = FormData.fromMap({
        "attachment":
        MultipartFile.fromBytes(bytes, filename: fileName),
      });
      Response response = await _createClient.post("/api/v1/article-attachment/create", data: formData);
      resp = CreateModel.fromJson(response.data);
      // debugPrint('Article id: ${resp.data?.id}');

    } on DioError catch (err) {
      var message = err.response?.data['message'];
      var error = err.response?.data['error'];
      // in case of message of error is 'Expired Signature' then will retry getNewId() after refresh the authToken
      resp = CreateModel(success: "", data: null, message: message, error: error);
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
      var message = err.response?.data['message'];
      var error = err.response?.data['error'];
      // in case of message of error is 'Expired Signature' then will retry getNewId() after refresh the authToken
      resp = PostArticleModel(success: "", data: null, message: message, error: error);
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

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();
  final TextEditingController categoryCtrl = TextEditingController();
  final TextEditingController htmlCtrl = TextEditingController();

  var isPostingImage = false;
  var isPostingArticle = false;
  bool isSelectedImage = false;
  var errorPostMessage = ''.obs;
  var gotAttachmentId = false.obs;
  var gotPostingId = false.obs;
  var attachmentId = ''.obs;
  var articleId = ''.obs;
  late String artTitle;
  late String artTopic;
  late DateTime postDate;
  late String imageFileName = '';
  Uint8List imageBytes = Uint8List(0);
  Uint8List htmlBytes = Uint8List(0);
  List<String> tagsList = [];

  var getIdResponse =
      CreateModel(success: "", data: null, message: "", error: "").obs;

  postGetArticleId() async {

    if(isSelectedImage) {
      errorPostMessage.value = '';
      isPostingImage = true;
        try {
          getIdResponse.value = (await _create.getNewId(bytes: imageBytes, fileName: imageFileName))!;
          isPostingImage = false;
          attachmentId.value = getIdResponse.value.data!.id!;
          if(attachmentId.isNotEmpty) {
            gotAttachmentId.value = true;
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

  postCreateArticle(String id) async {

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
        } catch (err) {
          isPostingImage = false;
          debugPrint("error  $err");
        }
      } else {
        debugPrint('Article invalid !');
      }
    } else {
      debugPrint('Article not ready to submit yet !');
    }
  }

  Future<String> selectImage() async {
    imageFileName = '';
    final mediaInfo = await ImagePickerWeb.getImageInfo;
    final data = mediaInfo?.data;

    if (data != null) {
      imageBytes = data;
      imageFileName = mediaInfo!.fileName!;
      isSelectedImage = true;
    }
    return imageFileName;
  }

  void getImageBytes(Uint8List data) {
    data = imageBytes;
  }

  void clearPhotoAndId() {
    attachmentId.value = '';
    gotAttachmentId.value = false;
    imageFileName = '';
    isSelectedImage = false;
  }

  Future<Uint8List?> uploadHtml() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.custom,
        allowedExtensions: ['txt', 'html']);
    htmlBytes = Uint8List(0);
    if (result != null) {
      PlatformFile file = result.files.first;
      htmlBytes = file.bytes!;
      // widgetCtrl = "";
      // for(var i=0 ; i < htmlBytes.buffer.asByteData().lengthInBytes; i++) {
      //   widgetCtrl = widgetCtrl + String.fromCharCode(htmlBytes.buffer.asByteData().getUint8(i));
      // }

    } else {
      // User canceled the picker
    }
    return htmlBytes;
  }

  bool isSubmitReady() {
    return (attachmentId != null && titleCtrl.value.text.isNotEmpty && htmlCtrl.value.text.isNotEmpty);
  }

  clearCreatePage() {
    if(gotPostingId.value) {
      attachmentId.value = '';
      articleId.value = '';
      isSelectedImage = false;
      gotAttachmentId.value = false;
      titleCtrl.clear();
      categoryCtrl.clear();
      dateCtrl.clear();
      htmlCtrl.clear();
      imageBytes = Uint8List(0);
      htmlBytes = Uint8List(0);
    } else {
      debugPrint('Posting article is not done yet !');
    }
  }
}

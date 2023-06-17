import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as milliseconds;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../constant/variables.dart';
import '../../../../services/dio_services.dart';
import '../../login/controllers/login_controller.dart';
import '../model/read_article_data.dart';
import './admin_api.dart';


class ReadProvider {
  final Dio _readClient;
  ReadProvider(this._readClient);

  Future<GetArticleList?> getArticleList(int page) async {
    GetArticleList? resp;
    int size = 10;

    try {
      FormData formData = FormData.fromMap({
      });
      Response response = await _readClient.get(
          "/api/v1/article/list?",
          queryParameters: {'search': '', 'page': page.toString(), 'page_size': size.toString()}
      );
      resp = GetArticleList.fromJson(response.data);

    } on DioError catch (err) {
      debugPrint('Get articles list fail with result: ${err.response?.statusCode}');
      var message = err.response?.data['message'];
      var error = err.response?.data['error'];
      // in case of message of error is 'Expired Signature' then will retry getNewId() after refresh the authToken
      resp = GetArticleList(success: "", data: null, message: "", error: "", links: null, count: null);
    }

    return resp;
  }
}

class ReadController extends GetxController {

  late AdminClient _client;
  late ReadProvider _read;

  @override
  void onInit() {
    _client = AdminClient();
    _read = ReadProvider(_client.init());
    super.onInit();
  }
  final accessCtrl = Get.find<LoginController>();
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController tagCtrl = TextEditingController();

  var isGettingArticles = false;
  var errorPostMessage = ''.obs;
  var gotArticleList = false.obs;
  List<GetArticleData>? fullArticlesList = [];
  List<ArticleListTable> articleListTable = [];

  var getArticleListResponse =
      GetArticleList(success: "", data: null, message: "", error: "", links: null, count: null).obs;

  Future<List<GetArticleData>?> initArticleList() async {

    errorPostMessage.value = '';
    isGettingArticles = true;

    try {
      getArticleListResponse.value = (await _read.getArticleList(1))!;
      debugPrint('Got ${getArticleListResponse.value.data?.length} articles !');
      isGettingArticles = false;
      fullArticlesList = getArticleListResponse.value.data?.toList();
      // articleListTable = fullArticlesList!.map((e) => (
      //     ArticleListTable(
      //     id: e.id,
      //     title: e.title,
      //     // tags: e.tags?.map((x) => {x.tags.map((y) => y.name)}).toList() as List<String>,
      //     htmlBody: e.renderedBody,
      //     creator: e.creator
      //   ))).toList();
      gotArticleList.value = true;
      // updateReadiness();
      return fullArticlesList;
    } catch (err) {
      isGettingArticles = false;
      debugPrint("error  $err");
      // in case of message of error is 'Expired Signature' then call tokenRefresh and retry
      if(getArticleListResponse.value.message == 'Expired Signature') {
        accessCtrl.tokenRefresh();
        _client.refreshOption();
        debugPrint('Access token just refreshed !');
        try {
          getArticleListResponse.value = (await _read.getArticleList(1))!;
          isGettingArticles = false;
          fullArticlesList = getArticleListResponse.value.data?.toList();
          articleListTable = fullArticlesList!.map((e) => (
              ArticleListTable(
                  id: e.id!,
                  title: e.title!,
                  // tags: e.tags?.map((x) => {x.tag?.map((y) => y.name)}).toList() as List<String>?,
                  tags: e.tags?.map((x) => {x.tag?.name}).toList() as List<String>?,
                  htmlBody: e.renderedBody!,
                  creator: e.creator
              ))).toList();
          gotArticleList.value = true;
          // updateReadiness();
          return fullArticlesList;
        } catch (err) {
          isGettingArticles = false;
          debugPrint("error  $err");
        }
      }
      return null;
    }
  }
}

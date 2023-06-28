import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as milliseconds;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
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
  final TextEditingController filterCtrl = TextEditingController();
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController tagCtrl = TextEditingController();

  var isGettingArticles = false.obs;
  var errorPostMessage = ''.obs;
  var gotArticleList = false.obs;
  int nbrOfArticles = 0;
  int gotArticles = 0;
  List<GetArticleData>? fullArticlesList = [];
  // List<ArticleListTable> articleListTable = [];
  var allArticleList = <ArticleListTable> [].obs;
  var filterArticleList = <ArticleListTable> [].obs;
  var sortColumnIndex = 0.obs;
  var sort = false.obs;

  var getArticleListResponse =
      GetArticleList(success: "", data: null, message: "", error: "", links: null, count: null).obs;

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        allArticleList.value.sort((a, b) => a.title!.compareTo(b.title!));
      } else {
        allArticleList.value.sort((a, b) => b.title!.compareTo(a.title!));
      }
    }
    if (columnIndex == 1) {
      if (ascending) {
        allArticleList.value.sort((a, b) => a.creator!.compareTo(b.title!));
      } else {
        allArticleList.value.sort((a, b) => b.creator!.compareTo(a.title!));
      }
    }
    // if (columnIndex == 2) {
    //   if (ascending) {
    //     allArticleList.sort((a, b) => a.tags.compareTo(b.creator!));
    //   } else {
    //     allArticleList.sort((a, b) => b.tags.compareTo(a.creator!));
    //   }
    // }
    sortColumnIndex = sortColumnIndex;
    sort = sort;
  }

  Future<List<GetArticleData>?> initArticleList() async {

    errorPostMessage.value = '';
    isGettingArticles.value = true;
    int page = 1;

    do {
      try {
        getArticleListResponse.value = (await _read.getArticleList(page))!;
        // fullArticlesList = getArticleListResponse.value.data?.toList();
        fullArticlesList?.addAll(getArticleListResponse.value.data as Iterable<GetArticleData>);
        if(gotArticles == 0) {
          nbrOfArticles = getArticleListResponse.value.count!;
          gotArticles += getArticleListResponse.value.data!.length;
        } else {
          gotArticles += getArticleListResponse.value.data!.length;
        }
      } catch (err) {
        isGettingArticles.value = false;
        debugPrint("error  $err");
        // in case of message of error is 'Expired Signature' then call tokenRefresh and retry
        if(getArticleListResponse.value.message == 'Expired Signature') {
          accessCtrl.tokenRefresh();
          _client.refreshOption();
          debugPrint('Access token just refreshed !');
          try {
            getArticleListResponse.value = (await _read.getArticleList(page))!;
            fullArticlesList?.addAll(getArticleListResponse.value.data as Iterable<GetArticleData>);
            if(gotArticles == 0) {
              nbrOfArticles = getArticleListResponse.value.count!;
              gotArticles += getArticleListResponse.value.data!.length;
            } else {
              gotArticles += getArticleListResponse.value.data!.length;
            }
            gotArticleList.value = true;
          } catch (err) {
            isGettingArticles.value = false;
            debugPrint("error  $err");
          }
        }
        if(gotArticles > 0) {
          gotArticleList.value = true;
          return fullArticlesList;
        } else {
          return null;
        }
      }
      // debugPrint('Got $gotArticles articles out of total $nbrOfArticles !');
      page++;
    } while (nbrOfArticles > gotArticles);

    allArticleList.value.addAll(fullArticlesList!.map((e) => (
        ArticleListTable(
            id: e.id!,
            title: e.title!,
            creator: e.creator,
            tags: listArticleTags(e.tags?.map((x) => x.tag?.name).toList() as List<String?>),
            // htmlBody: e.renderedBody!,
        ))).toList());
    // updateReadiness();
    filterArticleList.value = allArticleList.value;
    gotArticleList.value = true;
    isGettingArticles.value = false;
    return fullArticlesList;
  }

  String listArticleTags(List<String?> tags) {
    String list= '';
    for(int i=0 ; i < tags.length ; i++) {
      if(i > 0) {
        list += ', ';
      }
      list += tags[i]!;
    }
    return list;
  }

  clearFilter() {
    filterCtrl.clear();
    allArticleList.value = filterArticleList.value
        .where((element) => element.title!.contains(''))
        .toList();
    sortColumnIndex.value = sortColumnIndex.value;
    sort.value = false;
  }

  filterArticleTable(String value) {
    allArticleList.value = filterArticleList.value
        .where((element) => element.title!.contains(value))
        .toList();
  }

}

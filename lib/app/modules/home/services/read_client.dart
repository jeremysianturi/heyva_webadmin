import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as milliseconds;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../login/controllers/login_controller.dart';
import '../model/read_article_data.dart';
import './admin_api.dart';


class ReadProvider {
  final Dio _readClient;
  ReadProvider(this._readClient);

  Future<GetArticleList?> getArticleList(int page, String mode) async {
    GetArticleList? resp;
    int size = 10;

    try {
      Map<String, dynamic> queryPars;
      if(mode == 'Development') {
        queryPars = {
          'search': '',
          'page': page.toString(),
          'page_size': size.toString(),
          "app_env": mode
        };
        FormData formData = FormData.fromMap({
        });
      } else {
        queryPars = {
          'search': '',
          'page': page.toString(),
          'page_size': size.toString()
        };
      }

      Response response = await _readClient.get(
        "/api/v1/article/list?",
        // queryParameters: {'search': '', 'page': page.toString(), 'page_size': size.toString(),"app_env": mode}
        queryParameters: queryPars
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

  Future<TagsArticleModel?> getArticleTags() async {
    TagsArticleModel? resp;

    try {
      FormData formData = FormData.fromMap({
      });
      Response response = await _readClient.get(
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
  final TextEditingController creatorCtrl = TextEditingController();
  final TextEditingController htmlCtrl = TextEditingController();
  final TextEditingController tagCtrl = TextEditingController();

  var viewListMode = true.obs;
  var viewUpdateArticleMode = false.obs;
  var isGettingArticles = false.obs;
  var errorPostMessage = ''.obs;
  var gotArticleList = false.obs;
  late int nbrOfArticles;
  late int gotArticles;
  List<GetArticleData>? fullArticlesList = [];
  var displayArticleList = <ArticleListTable> [].obs;
  var cachedArticleList = <ArticleListTable> [].obs;
  var sortColumnIndex = 0.obs;
  var sort = false.obs;
  var selectedViewMode = ''.obs;
  var selectedArticleMode = ''.obs;
  late GetArticleData selectedArticle;
  var isGettingTags = false;
  List<TagsData>? fullTags = [];
  List<TagIdName> tagIdNames = [];
  var selectedTags = <TagIdName?>[].obs;
  var items = <MultiSelectItem<TagIdName>>[].obs;
  var itemsSelected = <MultiSelectItem<TagIdName>>[].obs;
  List<String> selectedTagsId = [];
  var gotTagsList = false.obs;
  // var firstTransaction = true.obs;
  List<TagIdName> initialArticleTags = [];

  var getArticleListResponse =
      GetArticleList(success: "", data: null, message: "", error: "", links: null, count: null).obs;

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        displayArticleList.value.sort((a, b) => a.title!.compareTo(b.title!));
      } else {
        displayArticleList.value.sort((a, b) => b.title!.compareTo(a.title!));
      }
    }
    if (columnIndex == 1) {
      if (ascending) {
        displayArticleList.value.sort((a, b) => a.creator!.compareTo(b.title!));
      } else {
        displayArticleList.value.sort((a, b) => b.creator!.compareTo(a.title!));
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

  Future<List<GetArticleData>?> initArticleList(String mode) async {

    fullArticlesList?.clear();
    errorPostMessage.value = '';
    isGettingArticles.value = true;
    gotArticles = 0;
    nbrOfArticles = 0;
    int page = 1;

    do {
      try {
        getArticleListResponse.value = (await _read.getArticleList(page, mode))!;
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
            getArticleListResponse.value = (await _read.getArticleList(page, mode))!;
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
      debugPrint('Got $gotArticles articles out of total $nbrOfArticles !');
      page++;
    } while (nbrOfArticles > gotArticles);

    displayArticleList.clear();
    displayArticleList.value.addAll(fullArticlesList!.map((e) => (
        ArticleListTable(
            id: e.id!,
            title: e.title!,
            creator: e.creator,
            tags: listArticleTags(e.tags?.map((x) => x.tag?.name).toList() as List<String?>),
            // htmlBody: e.renderedBody!,
        ))).toList());
    // updateReadiness();
    cachedArticleList.value = displayArticleList.value;
    gotArticleList.value = true;
    isGettingArticles.value = false;
    return fullArticlesList;
  }

/***********************************************************************************************/
  var getTagsResponse =
      TagsArticleModel(success: "", data: null, message: "", error: "").obs;

  Future<List<TagIdName>?> initArticleTagsList() async {

    errorPostMessage.value = '';
    isGettingTags = true;

    try {
      getTagsResponse.value = (await _read.getArticleTags())!;
      isGettingTags = false;
      fullTags = getTagsResponse.value.data?.toList();
      tagIdNames = fullTags!.map((e) => (TagIdName(id: e.id!, name: e.name!))).toList();
      items.value = tagIdNames!.map((tag) => MultiSelectItem<TagIdName>(tag, tag.name)).toList();
      gotTagsList.value = true;
      return tagIdNames;
    } catch (err) {
      isGettingTags = false;
      debugPrint("error  $err");
      // in case of message of error is 'Expired Signature' then call tokenRefresh and retry
      if(getTagsResponse.value.message == 'Expired Signature') {
        accessCtrl.tokenRefresh();
        _client.refreshOption();
        try {
          getTagsResponse.value = (await _read.getArticleTags())!;
          isGettingTags = false;
          fullTags = getTagsResponse.value.data?.toList();
          tagIdNames = fullTags!.map((e) => (TagIdName(id: e.id!, name: e.name!))).toList();
          items.value = tagIdNames!.map((tag) => MultiSelectItem<TagIdName>(tag, tag.name)).toList();
          gotTagsList.value = true;
          return tagIdNames;
        } catch (err) {
          isGettingTags = false;
          debugPrint("error  $err");
        }
      }
      return null;
    }
  }
/***********************************************************************************************/

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
    displayArticleList.value = cachedArticleList.value
        .where((element) => element.title!.contains(''))
        .toList();
    sortColumnIndex.value = sortColumnIndex.value;
    sort.value = false;
  }

  filterArticleTable(String value) {
    displayArticleList.value = cachedArticleList.value
        .where((element) => element.title!.contains(value))
        .toList();
  }

  bool getSelectedArticle(String id) {
    bool found = false;
    // firstTransaction.value = true;

    for(var i=0 ; i < fullArticlesList!.length ; i++) {
      if(fullArticlesList?[i].id == id) {
        selectedArticle = fullArticlesList![i];
        titleCtrl.text = selectedArticle.title!;
        tagCtrl.text = listArticleTags(selectedArticle.tags?.map((x) => x.tag?.name).toList() as List<String?>);
        // initialize selected tags in multiselect chip
        initialArticleTags = selectedArticle.tags!.map(
                (e) => TagIdName(id: e.tag!.id!, name: e.tag!.name!)
        ).toList();
        creatorCtrl.text = selectedArticle.creator!;
        htmlCtrl.text = selectedArticle.renderedBody!;
        found = true;
        break;
      }
    }
    if(found) {
      viewListMode.value = false;
      selectedArticleMode.value = selectedViewMode.value;
    }
    return found;
  }

  restoreSelectedArticle() {
    // firstTransaction.value = true;
    titleCtrl.text = selectedArticle.title!;
    creatorCtrl.text = selectedArticle.creator!;
    htmlCtrl.text = selectedArticle.renderedBody!;
    tagCtrl.text = listArticleTags(selectedArticle.tags?.map((x) => x.tag?.name).toList() as List<String?>);
    // initialize selected tags in multiselect chip
    initialArticleTags = selectedArticle.tags!.map(
            (e) => TagIdName(id: e.tag!.id!, name: e.tag!.name!)
    ).cast<TagIdName>().toList();
    viewListMode.value = false;
    selectedArticleMode.value = selectedViewMode.value;
  }
  updateSelectedTagsId() {
    itemsSelected.value = selectedTags.value.map(
            (tag) => MultiSelectItem<TagIdName>(tag!, tag.name)
    ).toList();
    selectedTagsId = selectedTags.value.map((e) => e!.id).toList();
  }

  selectedItemsDisplayChip(List<String> labels) {
    // items.value.where((tag) => tag.label.contains(label)).toList();
    for(int i = 0 ; i < labels.length ; i++) {
      items.value.where((tag) =>
      (tag.label.contains(labels[i]))).map((e) => e.selected = true).toList();
      itemsSelected.value.where((tag) =>
      (tag.label.contains(labels[i]))).map((e) => e.selected = true).toList();
    }
  }
}

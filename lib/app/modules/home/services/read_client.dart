
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as milliseconds;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
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
      if(mode == 'development') {
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

  Future<UpdateArticleModel?> updateExistingArticle({
    required String artId,
    required String title,
    required String body,
    required String creator,
    required String? banner,
    required String? thumbnail,
    required List<String?> tagsId,
    // required String mode,
  }) async {
    UpdateArticleModel? resp;

    try {
      FormData formData = FormData.fromMap({
        "title": title,
        "body": body,
        "creator": creator,
        "banner": banner,
        "thumbnail": thumbnail,
      });
      for(int i=0 ; i < tagsId.length ; i++) {
        formData.fields.add(MapEntry("tag", tagsId[i]!));
      }
      debugPrint("check dulu : ${formData.fields}");
      // formData.fields.add(MapEntry("app_env", mode));
      Response response = await _readClient.put("/api/v1/article/update/$artId", data: formData);
      resp = UpdateArticleModel.fromJson(response.data);

    } on DioError catch (err) {
      debugPrint('Update fail with result: ${err.response}');
      var message = err.response?.data['message'];
      var error = err.response?.data['error'];
      // in case of message of error is 'Expired Signature' then will retry postNewAttachment() after refresh the authToken
      resp = UpdateArticleModel(success: "", data: null, message: message, error: error);
    }

    return resp;
  }

  Future<DeleteArticleModel?> deleteExistingArticle({
    required String artId,
    // required String mode,
  }) async {
    DeleteArticleModel? resp;

    try {
      Response response = await _readClient.delete("/api/v1/article/delete/$artId");
      resp = DeleteArticleModel.fromJson(response.data);

    } on DioError catch (err) {
      debugPrint('Delete fail with result: ${err.response}');
      var message = err.response?.data['message'];
      var error = err.response?.data['error'];
      // in case of message of error is 'Expired Signature' then will retry postNewAttachment() after refresh the authToken
      resp = DeleteArticleModel(success: "", data: null, message: message, error: error);
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
  final TextEditingController dateCtrl = TextEditingController();

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
  List<String?> selectedTagsId = [""];
  var gotTagsList = false.obs;
  // var firstTransaction = true.obs;
  List<TagIdName> initialArticleTags = [];
  var selectedId = "".obs;
  var isUpdatingArticle = false;
  var attachmentId = ''.obs;
  var articleId = '';
  var gotUpdatingId = false.obs;
  var isUpdatingReady = false.obs;
  var totalArticleProd = 0.obs;
  var totalArticleDev = 0.obs;
  var totalArticle = 0.obs;


  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        displayArticleList.value.sort((a, b) => a.title.compareTo(b.title));
      } else {
        displayArticleList.value.sort((a, b) => b.title.compareTo(a.title));
      }
    }
    if (columnIndex == 1) {
      if (ascending) {
        displayArticleList.value.sort((a, b) => a.creator!.compareTo(b.title));
      } else {
        displayArticleList.value.sort((a, b) => b.creator!.compareTo(a.title));
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

  var getArticleListResponse =
      GetArticleList(success: "", data: null, message: "", error: "", links: null, count: null).obs;

  Future<List<GetArticleData>?> initArticleList(String mode) async {

    fullArticlesList?.clear();
    errorPostMessage.value = '';
    isGettingArticles.value = true;
    gotArticles = 0;
    nbrOfArticles = 0;
    int page = 1;

    debugPrint("ini masalahnya2");

    do {
      try {
        debugPrint("check value mode: $mode");
        getArticleListResponse.value = (await _read.getArticleList(page, mode))!;
        debugPrint("check value getArticleListResponse: ${getArticleListResponse.value.data?.length}");
        fullArticlesList?.addAll(getArticleListResponse.value.data as Iterable<GetArticleData>);
        if(gotArticles == 0) {
          nbrOfArticles = getArticleListResponse.value.count!;
          gotArticles += getArticleListResponse.value.data!.length;
        } else {
          gotArticles += getArticleListResponse.value.data!.length;
        }
      } catch (err) {
        isGettingArticles.value = false;
        debugPrint("error#1  $err");
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
            debugPrint("error#2  $err");
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

  Future<int> getArticleTotal() async {

    int page = 1;

      try {
        getArticleListResponse.value = (await _read.getArticleList(page, "development"))!;
        if(totalArticleDev.value == 0){
          totalArticleDev.value = getArticleListResponse.value.count!;
        }
      } catch (err) {
        isGettingArticles.value = false;
        debugPrint("error#10 $err");
      }

    try {
      getArticleListResponse.value = (await _read.getArticleList(page, "production"))!;
      if(totalArticleProd.value == 0){
        totalArticleProd.value += getArticleListResponse.value.count!;
      }
    } catch (err) {
      isGettingArticles.value = false;
      debugPrint("error#11 $err");
    }

    if(totalArticle.value == 0) {
      totalArticle.value = totalArticleDev.value + totalArticleProd.value;
    }

    debugPrint("check value totalArticle ${totalArticle}");

    return totalArticleProd.value;
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
      debugPrint("error#3  $err");
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
          debugPrint("error#4  $err");
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
        .where((element) => element.title.toLowerCase().contains(''))
        .toList();
    sortColumnIndex.value = sortColumnIndex.value;
    sort.value = false;
  }

  filterArticleTable(String value) {
    displayArticleList.value = cachedArticleList.value
        .where((element) => element.title.toLowerCase().contains(value))
        .toList();
  }

  bool getSelectedArticle(String id) {
    bool found = false;
    // firstTransaction.value = true;

    for(var i=0 ; i < fullArticlesList!.length ; i++) {
      if(fullArticlesList?[i].id == id) {
        selectedArticle = fullArticlesList![i];
        articleId = selectedArticle.id!;
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

  List<String?> getTagStringList(){
    return selectedArticle.tags?.map((x) => x.tag?.name).toList() as List<String?>;
  }

  List<String?> getInitialTagIdList(){
    return selectedArticle.tags?.map((x) => x.tag?.id).toList() as List<String?>;
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

  var updateArticleResponse =
      UpdateArticleModel(success: "", data: null, message: "", error: "").obs;

  Future<String> updateArticle(List<String?> id) async {

    // if (id == attachmentId.value) {
      errorPostMessage.value = '';
      isUpdatingArticle = true;
      try {
        debugPrint("check dulu ya: $selectedTagsId");
        updateArticleResponse.value = (await _read.updateExistingArticle(
          artId: articleId,
          title: titleCtrl.value.text,
          body: htmlCtrl.value.text,
          creator: creatorCtrl.value.text,
          banner: selectedArticle.banner,
          thumbnail: selectedArticle.thumbnail,
          tagsId: id,
            // mode: selectedMode.value
        ))!;
        isUpdatingArticle = false;
        articleId = updateArticleResponse.value.data!.id!;
        if(articleId.isNotEmpty) {
          gotUpdatingId.value = true;
          updateReadiness();
        }
        return articleId;
      } catch (err) {
        isUpdatingArticle = false;
        debugPrint("update error: $err");
        // in case of message of error is 'Expired Signature' then call tokenRefresh and retry
        if(updateArticleResponse.value.message == 'Expired Signature') {
          accessCtrl.tokenRefresh();
          _client.refreshOption();
          try {
            updateArticleResponse.value = (await _read.updateExistingArticle(
              artId: articleId,
              title: titleCtrl.value.text,
              body: htmlCtrl.value.text,
              creator: creatorCtrl.value.text,
              banner: selectedArticle.banner,
              thumbnail: selectedArticle.thumbnail,
              tagsId: id,
                // mode: selectedMode.value.toLowerCase()
            ))!;
            isUpdatingArticle = false;
            articleId = updateArticleResponse.value.data!.id!;
            if(articleId.isNotEmpty) {
              gotUpdatingId.value = true;
              updateReadiness();
            }
            return articleId;
          } catch (err) {
            isUpdatingArticle = false;
            debugPrint("error#4  $err");
          }
        }
        return '';
      }
    // } else {
    //   debugPrint('Article invalid !');
    //   return '';
    // }
  }

  bool updateReadiness() {

    if(
    titleCtrl.text.isNotEmpty &&
        creatorCtrl.text.isNotEmpty &&
        dateCtrl.text.isNotEmpty &&
        htmlCtrl.text.isNotEmpty &&
        attachmentId.value.isNotEmpty &&
        titleCtrl.value.text.isNotEmpty &&
        creatorCtrl.value.text.isNotEmpty &&
        dateCtrl.value.text.isNotEmpty &&
        selectedTagsId.isNotEmpty &&
        htmlCtrl.value.text.isNotEmpty
    ) {
      isUpdatingReady.value = true;
    }
    return isUpdatingReady.value;
  }

  var deleteArticleResponse =
      DeleteArticleModel(success: "", data: null, message: "", error: "").obs;

  Future<String> deleteArticle(String? id) async {

    // if (id == attachmentId.value) {
    try {
      debugPrint("check value delete id: $id");
      deleteArticleResponse.value = (await _read.deleteExistingArticle(
        artId: id!,
      ))!;
      debugPrint("check 1111 : ${deleteArticleResponse.value.success!}");
      return deleteArticleResponse.value.success!;
    } catch (err) {
      debugPrint("update error: $err");
      // in case of message of error is 'Expired Signature' then call tokenRefresh and retry
      if(updateArticleResponse.value.message == 'Expired Signature') {
        accessCtrl.tokenRefresh();
        _client.refreshOption();
        try {
          deleteArticleResponse.value = (await _read.deleteExistingArticle(
            artId: id!,
          ))!;

          return id;
        } catch (err) {
          isUpdatingArticle = false;
          debugPrint("error#4  $err");
        }
      }
      return '';
    }
    // } else {
    //   debugPrint('Article invalid !');
    //   return '';
    // }
  }


}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../model/read_article_data.dart';
import '../../../../constant/colors.dart';
import '../controllers/menu_controller.dart';
import '../services/read_client.dart';


class ViewArticlePage extends StatelessWidget {
  ViewArticlePage({Key? key}) : super(key: key);
  static ReadController readCtrl = Get.find<ReadController>();
  final _multiSelectKey = GlobalKey<FormFieldState>();

  late List<TagIdName>? tagIdNames;
  late String articleId;

  void initTags() async {
    tagIdNames = await readCtrl.initArticleTagsList();
  }

  void initReadArticles(String mode) async {
    await readCtrl.initArticleList(mode);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String pageName = sideMenuItems[SideMenuItems.viewArticle.index];
    final List<String> selectionMode = ['Development', 'Production'];

    if(readCtrl.tagIdNames.isEmpty) {
      initTags();
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => readCtrl.viewListMode.value ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    pageName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  const SizedBox(width: 260,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 30,
                      child: DropdownButton(
                        // padding: const EdgeInsets.symmetric(horizontal: 20),
                        hint: const Text('Select Mode'),
                        alignment: AlignmentDirectional.center,
                        value: readCtrl.selectedViewMode.value.isEmpty ? null : readCtrl.selectedViewMode.value,
                        onChanged: (newValue) {
                          if(readCtrl.selectedViewMode.value != newValue!) {
                            readCtrl.selectedViewMode.value = newValue;
                            readCtrl.gotArticleList.value = false;
                            initReadArticles(readCtrl.selectedViewMode.value.toLowerCase());
                          }
                        },
                        style: const TextStyle(fontSize: 14, color: ColorApp.white_font),
                        focusColor: ColorApp.btn_grey,
                        // dropdownColor: ColorApp.btn_pink,
                        borderRadius: BorderRadius.circular(10),
                        items: selectionMode.map((choice) {
                          return DropdownMenuItem(
                            value: choice,
                            child: Text(choice, style: const TextStyle(color: ColorApp.black_font),),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              readCtrl.selectedViewMode.value.isEmpty ? const Center(child: Text('Please select task mode first !!!'),)
              // : readCtrl.isGettingArticles.value ? const Center(child: Text('Downloading articles list !!!'),)
              : readCtrl.isGettingArticles.value ? const Center(child: CircularProgressIndicator(
                backgroundColor: ColorApp.grey_card_font,
                valueColor: AlwaysStoppedAnimation<Color>(ColorApp.btn_pink),

              ),)
              : SizedBox(
                width: double.infinity,
                child: Theme(
                  data: ThemeData.light()
                      .copyWith(cardColor: Theme.of(context).canvasColor),
                  child: PaginatedDataTable(
                    sortColumnIndex: readCtrl.sortColumnIndex.value,
                    sortAscending: readCtrl.sort.value,
                    header: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: readCtrl.filterCtrl,
                        decoration: InputDecoration(
                          hintText: "Enter key word to filter",
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: Colors.grey,
                          suffixIcon: IconButton(
                            onPressed: () {
                              readCtrl.clearFilter();
                            },
                            icon: const Icon(Icons.clear, color: Colors.grey,),
                          ),
                        ),
                        onChanged: (value) {
                          readCtrl.filterArticleTable(value);
                        },
                      ),
                    ),
                    source: ArticleData(
                      dataArticle: readCtrl.displayArticleList.value,
                      count: readCtrl.displayArticleList.value.length,
                      context: context,
                    ),
                    rowsPerPage: 10,
                    columnSpacing: 20,
                    // dataRowMaxHeight: 38,
                    // dataRowMinHeight: 28,
                    columns: getColumns(),
                  ),
                ),
              ),
            ],
          )
          : Column(
            children: [
              // Header admin page in view an article
              Row(
                children: <Widget>[
                  Text(
                    '$pageName :: ${readCtrl.selectedArticle.title}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  // const Spacer(),
                ],
              ),
              // task mode option "app_env": Development or Production
              Row(
                children: [
                  const Spacer(),
                  // const SizedBox(width: 260,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 30,
                      // width: 40,
                      child: DropdownButton(
                        // padding: const EdgeInsets.symmetric(horizontal: 20),
                        hint: const Text('Select Task Mode'),
                        value: readCtrl.selectedArticleMode.value.isEmpty ? null : readCtrl.selectedArticleMode.value,
                        onChanged: (newValue) {
                          // if(attachmentId.isEmpty) {
                          readCtrl.selectedArticleMode.value = newValue!;
                          // }
                        },
                        style: const TextStyle(fontSize: 14, color: ColorApp.white_font),
                        focusColor: ColorApp.btn_grey,
                        // dropdownColor: ColorApp.btn_pink,
                        borderRadius: BorderRadius.circular(10),
                        items: selectionMode.map((choice) {
                          return DropdownMenuItem(
                            enabled: readCtrl.viewUpdateArticleMode.value,
                            value: choice,
                            child: Text(choice, style: const TextStyle(color: ColorApp.black_font),),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              // Article title field
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 160,
                    child: Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          enabled: readCtrl.viewUpdateArticleMode.value,
                          onChanged: (text) {
                            // createCtrl.updateReadiness();
                          },
                          controller: readCtrl.titleCtrl,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            // hintText: 'Article title',
                            fillColor: CupertinoColors.secondarySystemFill,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
                          ),
                          cursorColor: ColorApp.grey_font,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              // Multi-select chips for interest article tags selection
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 160,
                    child: Text(
                      'Article Tags',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  // const SizedBox(width: 10,),
                  Expanded(
                    child: readCtrl.viewUpdateArticleMode.value ?
                      MultiSelectBottomSheetField<TagIdName?>(
                        key: _multiSelectKey,
                        initialChildSize: 0.7,
                        maxChildSize: 0.95,
                        title: const Text("Interest Tags", style: TextStyle(color: ColorApp.grey_font),),
                        buttonText: const Text("Selected Tags", style: TextStyle(color: ColorApp.grey_font),),
                        items: readCtrl.items.value,
                        searchable: true,
                        selectedColor: ColorApp.btn_pink,
                        selectedItemsTextStyle: const TextStyle(color: ColorApp.btn_pink),
                        validator: (values) {
                          if (values == null || values.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        initialValue: readCtrl.initialArticleTags.map((x) =>
                          readCtrl.tagIdNames.firstWhere((e) => e.name == x.name)).toList(),
                        onConfirm: (values) {
                          // if(readCtrl.firstTransaction.value) {
                          //   for(int i=0 ; i < readCtrl.initialArticleTags.length ; i++) {
                          //     values.addAll([readCtrl.tagIdNames.firstWhere(
                          //         (e) => e.name == readCtrl.initialArticleTags[i].name)
                          //     ]);
                          //   }
                          //   readCtrl.firstTransaction.value = false;
                          // }
                          readCtrl.selectedTags.value = values;
                          _multiSelectKey.currentState!.validate();
                          readCtrl.updateSelectedTagsId();
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          // read: https://github.com/CHB61/multi_select_flutter/issues/5
                          // items: readCtrl.itemsSelected.value,
                          chipColor: ColorApp.btn_pink,
                          textStyle: const TextStyle(color: ColorApp.white_font),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          onTap: (item) {
                            readCtrl.selectedTags.value.remove(item);
                            _multiSelectKey.currentState!.validate();
                            readCtrl.updateSelectedTagsId();
                          },
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextField(
                          // enabled: readCtrl.viewUpdateArticleMode.value,
                          enabled: false,
                          minLines: 1,
                          maxLines: 2,
                          onChanged: (text) {
                          },
                          controller: readCtrl.tagCtrl,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            fillColor: CupertinoColors.secondarySystemFill,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
                          ),
                          cursorColor: ColorApp.grey_font,
                        ),
                      ),
                  ),
                  const SizedBox(width: 10,),
                ],
              ),
              const SizedBox(height: 20,),
              // Article creator field
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 160,
                    child: Text(
                      'Creator',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          enabled: readCtrl.viewUpdateArticleMode.value,
                          onChanged: (text) {
                            // createCtrl.updateReadiness();
                          },
                          controller: readCtrl.creatorCtrl,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: 'Article creator',
                            fillColor: CupertinoColors.secondarySystemFill,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
                          ),
                          cursorColor: ColorApp.grey_font,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              // Content body - rendered html
              Padding(
                padding: const EdgeInsets.only(top:8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 160,
                      child: Text(
                        'Article content',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
              Container(
                height: 600,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                // color: ColorApp.grey_divider,
                child: TextField(
                  enabled: readCtrl.viewUpdateArticleMode.value,
                  onTap: () {
                    // createCtrl.updateReadiness();
                  },
                  controller: readCtrl.htmlCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    // hintText: 'Article content [html]',
                    fillColor: CupertinoColors.secondarySystemFill,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
                  ),
                  cursorColor: Colors.black,
                  maxLines: 1000,
                  style: const TextStyle(color: ColorApp.grey_font),
                ),
              ),
              const SizedBox(height: 20,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 200.0, top: 8.0, right: 200, bottom: 8),
                  child: Row(
                    children: [
                      readCtrl.viewUpdateArticleMode.value ?
                      ElevatedButton(
                        onPressed: () {
                          readCtrl.restoreSelectedArticle();
                          readCtrl.viewUpdateArticleMode.value = false;
                        },
                        child: const Text('Cancel'),
                      )
                      : ElevatedButton(
                        onPressed: () {
                          readCtrl.viewUpdateArticleMode.value = false;
                          readCtrl.viewListMode.value = true;
                        },
                        child: const Text('Close'),
                      ),
                      const Spacer(),
                      readCtrl.viewUpdateArticleMode.value ?
                      ElevatedButton(
                        onPressed: () async {
                          articleId = await readCtrl.updateArticle(readCtrl.selectedTagsId);
                          resetAfterArticleUpdate();
                        },
                        child: const Text('Save'),
                      )
                      : ElevatedButton(
                        onPressed: () {
                          debugPrint("check value readCtrl: ${readCtrl.itemsSelected}");
                          for(int i=0 ; i < readCtrl.itemsSelected.value.length ; i++) {
                            readCtrl.itemsSelected.value[i].selected = true;
                          }
                          readCtrl.viewUpdateArticleMode.value = true;
                          readCtrl.selectedTags.value = readCtrl.initialArticleTags.map((x) =>
                              readCtrl.tagIdNames.firstWhere((e) => e.name == x.name)).toList();
                          readCtrl.updateSelectedTagsId();
                        },
                        child: const Text('Edit'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  void resetAfterArticleUpdate() {
    readCtrl.viewUpdateArticleMode.value = false;
    readCtrl.viewListMode.value = true;
    readCtrl.gotArticleList.value = false;
    initReadArticles(readCtrl.selectedViewMode.value.toLowerCase());
  }

  List<DataColumn> getColumns() {
    return [
      DataColumn(
          label: const Text(
            "Title",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14),
          ),
          onSort: (columnIndex, ascending) {
            readCtrl.sortColumnIndex.value = columnIndex;
            readCtrl.sort.value = ascending;
            readCtrl.onSortColumn(columnIndex, ascending);
          }
      ),
      DataColumn(
        label: const Text(
          "Creator",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14),
        ),
          onSort: (columnIndex, ascending) {
            readCtrl.sortColumnIndex.value = columnIndex;
            readCtrl.sort.value = ascending;
            readCtrl.onSortColumn(columnIndex, ascending);
          }
      ),
      const DataColumn(
        label: Text(
          "Tags",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      const DataColumn(
        label: Text(
          "",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    ];
  }
}

class ArticleData extends DataTableSource {
  var dataArticle;
  final count;
  final context;
  ArticleData({
    required this.dataArticle,
    required this.count,
    required this.context,
  });
  static ReadController readCtrl = Get.find<ReadController>();

  void viewArticle(int index, String id) {
    bool found;
    // dispatch method to display the selected article on index basis
    if(!(found = readCtrl.getSelectedArticle(id))) {
      debugPrint('Article not exist !');
    } else {
      debugPrint('this will invoke a widget to display article[$index]: "$id" !');
      readCtrl.selectedId.value = id;
    }
  }

  Future<void> deleteArticle(int index, String id) async {
    var deleteStatus = await readCtrl.deleteArticle(id);
    debugPrint("check value success response delete: $deleteStatus}");
    if(deleteStatus == "Success"){
      resetAfterArticleUpdate();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Delete fail"),
      ));
    }

  }

  void resetAfterArticleUpdate() {
    readCtrl.viewUpdateArticleMode.value = false;
    readCtrl.viewListMode.value = true;
    readCtrl.gotArticleList.value = false;
    initReadArticles(readCtrl.selectedViewMode.value.toLowerCase());
  }

  void initReadArticles(String mode) async {
    await readCtrl.initArticleList(mode);
  }

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(dataArticle![index], index, viewArticle, deleteArticle);
    } else {
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

// DataRow recentFileDataRow(var data) {
DataRow recentFileDataRow(var data, int index, Function onSelectRow, Function onDeleteRow) {
  return DataRow.byIndex(
    index: index,
    cells: [
      DataCell(Text(data.title ?? "Title"), onTap: () => onSelectRow(index, data.id)),
      DataCell(Text(data.creator ?? "Literature / News")),
      DataCell(Text(data.tags)),
      DataCell(const Icon(Icons.delete,color: Colors.black26,),onTap: () => onDeleteRow(index, data.id)),
    ],
  );
}


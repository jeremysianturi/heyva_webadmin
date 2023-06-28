import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/menu_controller.dart';
import '../services/read_client.dart';


class ViewArticlePage extends StatelessWidget {
  ViewArticlePage({Key? key}) : super(key: key);
  static ReadController readCtrl = Get.find<ReadController>();

  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController dateEditingController = TextEditingController();
  final TextEditingController categoryEditingController = TextEditingController();
  final TextEditingController htmlEditingController = TextEditingController();

  void initReadArticles() async {
    await readCtrl.initArticleList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String pageName = sideMenuItems[SideMenuItems.viewArticle.index];
    if(!readCtrl.gotArticleList.value) {
      initReadArticles();
    }
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => readCtrl.isGettingArticles.value ? Container()
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    pageName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: TitleField(),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 20,),
              SizedBox(
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
                      myData: readCtrl.allArticleList.value,
                      count: readCtrl.allArticleList.value.length,
                    ),
                    rowsPerPage: 10,
                    columnSpacing: 20,
                    dataRowMaxHeight: 38,
                    dataRowMinHeight: 28,
                    columns: getColumns(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
      )

    ];
  }
}

class ArticleData extends DataTableSource {
  var myData;
  final count;
  ArticleData({
    required this.myData,
    required this.count,
  });

  void viewArticle() {
    debugPrint('this will invoke a widget to display an article !');
  }

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      // return recentFileDataRow(myData![index]);
      return recentFileDataRow(myData![index], index, viewArticle);
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
DataRow recentFileDataRow(var data, int index, Function onSelectRow) {
  return DataRow.byIndex(
    index: index,
    // selected: data.selected,
    // onSelectChanged: (value) {
    //   if(data.selected != value) {
    //     data.selected = value;
    //     onSelectRow();
    //   }
    // },
    cells: [
      DataCell(Text(data.title ?? "Title")),
      DataCell(Text(data.creator ?? "Literature / News")),
      DataCell(Text(data.tags)),
    ],
  );
}


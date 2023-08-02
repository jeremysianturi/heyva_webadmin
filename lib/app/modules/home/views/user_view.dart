import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../controllers/auth_controller.dart';
import '../controllers/menu_controller.dart';
import '../services/dashboard_client.dart';

class UserView extends StatelessWidget {
  UserView({Key? key}) : super(key: key);
  static ReadUserController readUserCtrl = Get.find<ReadUserController>();
  final _multiSelectKey = GlobalKey<FormFieldState>();

  late String userId;

  // void initReadUser() async {
  //   await readUserCtrl.initUserList();
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String pageName = sideMenuItems[SideMenuItems.user.index];

    // if(readUserCtrl.cachedUserList.isEmpty) {
    //   initReadUser();
    // }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  pageName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Container(),
              ],
            ),
            const SizedBox(height: 20,),
            readUserCtrl.isGettingUsers.value ? const Center(child: CircularProgressIndicator(
              backgroundColor: ColorApp.grey_card_font,
              valueColor: AlwaysStoppedAnimation<Color>(ColorApp.btn_pink),
            ),)
                : SizedBox(
              width: double.infinity,
              child: Theme(
                data: ThemeData.light()
                    .copyWith(cardColor: Theme.of(context).canvasColor),
                child: PaginatedDataTable(
                  sortColumnIndex: readUserCtrl.sortColumnIndex.value,
                  sortAscending: readUserCtrl.sort.value,
                  header: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: readUserCtrl.filterCtrl,
                      decoration: InputDecoration(
                        hintText: "Enter key word to filter",
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.grey,
                        suffixIcon: IconButton(
                          onPressed: () {
                            readUserCtrl.clearFilter();
                          },
                          icon: const Icon(Icons.clear, color: Colors.grey,),
                        ),
                      ),
                      onChanged: (value) {
                        readUserCtrl.filterUserTable(value);
                      },
                    ),
                  ),
                  source: UserData(
                    dataUser: readUserCtrl.displayUserList.value,
                    count: readUserCtrl.displayUserList.value.length,
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
        ),
        ),
      ),
    );
  }


  List<DataColumn> getColumns() {
    return [
      DataColumn(
          label: const Text(
            "Username",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14),
          ),
          onSort: (columnIndex, ascending) {
            readUserCtrl.sortColumnIndex.value = columnIndex;
            readUserCtrl.sort.value = ascending;
            readUserCtrl.onSortColumn(columnIndex, ascending);
          }
      ),
      DataColumn(
          label: const Text(
            "Email",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14),
          ),
          onSort: (columnIndex, ascending) {
            readUserCtrl.sortColumnIndex.value = columnIndex;
            readUserCtrl.sort.value = ascending;
            readUserCtrl.onSortColumn(columnIndex, ascending);
          }
      ),
      const DataColumn(
        label: Text(
          "Phone Number",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      const DataColumn(
        label: Text(
          "Last Login",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    ];
  }
}

class UserData extends DataTableSource {
  var dataUser;
  final count;
  final context;
  UserData({
    required this.dataUser,
    required this.count,
    required this.context,
  });
  static ReadUserController readUserCtrl = Get.find<ReadUserController>();

  // void initReadUsers() async {
  //   await readUserCtrl.initUserList();
  //   debugPrint("check value data user: $dataUser dan count: $count ");
  // }

  @override
  DataRow? getRow(int index) {
    debugPrint("check value index: $index dan check value row count: $rowCount");
    if (index < rowCount) {
      return recentFileDataRow(dataUser![index], index);
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
DataRow recentFileDataRow(var data, int index) {
  return DataRow.byIndex(
    index: index,
    cells: [
      DataCell(Text(data.username ?? "Username")),
      DataCell(Text(data.email ?? "Email")),
      DataCell(Text(data.phoneNumber)),
      DataCell(Text(data.lastLogin)),
    ],
  );
}

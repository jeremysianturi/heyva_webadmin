import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:heyva_web_admin/app/modules/home/views/dashboard_view.dart';
import 'package:heyva_web_admin/app/modules/home/views/post_article.dart';
import 'package:heyva_web_admin/app/modules/home/views/read_article.dart';
import 'package:heyva_web_admin/app/modules/home/views/update_article.dart';
import '../../../controllers/counter_controller.dart';
import '../../../widgets/layout_screen.dart';

class HomeViewAdmin extends StatefulWidget {
  const HomeViewAdmin({Key? key}) : super(key: key);

  @override
  State<HomeViewAdmin> createState() => _HomeViewAdminState();
}

class _HomeViewAdminState extends State<HomeViewAdmin> {
  final CounterController counterController = Get.put(CounterController());
  // HomeAdminView({super.key});

  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();
  @override
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const LayoutScreen();
    // return Scaffold(
    //   appBar: AppBar(
    //     elevation: 0,
    //     backgroundColor: Colors.white,
    //     title: Row(
    //       children: [
    //         SizedBox(
    //           width: 160,
    //           height: MediaQuery.of(context).size.height,
    //           child: Container(
    //             padding: EdgeInsets.only(left: 60, top: 20, right: 20, bottom: 20),
    //             child: SvgPicture.asset(
    //               "assets/images/heyva_logo.svg",
    //               fit: BoxFit.contain,
    //             ),
    //           ),
    //         ),
    //         const Expanded(
    //           child: Center(
    //             child: Text(
    //               "ARTICLE MANAGEMENT",
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.deepOrange,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   body: Row(
    //     children: <Widget>[
    //       Expanded(
    //         child: SideMenu(
    //           controller: sideMenu,
    //           style: SideMenuStyle(
    //             // showTooltip: false,
    //             displayMode: SideMenuDisplayMode.auto,
    //             hoverColor: Colors.deepOrange[100],
    //             selectedColor: Colors.deepOrange,
    //             selectedTitleTextStyle: const TextStyle(
    //               color: Colors.white,
    //               fontSize: 16,
    //             ),
    //             unselectedTitleTextStyle: const TextStyle(
    //               fontSize: 16,
    //             ),
    //             selectedIconColor: Colors.white,
    //             iconSize: 16,
    //           ),
    //           title: const Padding(
    //             padding: EdgeInsets.all(8.0),
    //             child: Text(
    //               "Admin",
    //               style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.black54,
    //               ),
    //             ),
    //           ),
    //           items: [
    //             SideMenuItem(
    //               priority: 0,
    //               title: 'Dashboard',
    //               onTap: (page, _) {
    //                 debugPrint("Page: $page - Dashboard");
    //                 sideMenu.changePage(page);
    //               },
    //               icon: const Icon(Icons.home),
    //             ),
    //             SideMenuItem(
    //               priority: 1,
    //               title: 'New Article',
    //               onTap: (page, _) {
    //                 sideMenu.changePage(page);
    //               },
    //               icon: const Icon(Icons.post_add),
    //               trailing: Container(
    //                   decoration: const BoxDecoration(
    //                       color: Colors.amber,
    //                       borderRadius: BorderRadius.all(Radius.circular(6))),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         horizontal: 6.0, vertical: 3),
    //                     child: Text(
    //                       'New',
    //                       style: TextStyle(fontSize: 11, color: Colors.grey[800]),
    //                     ),
    //                   )),
    //             ),
    //             SideMenuItem(
    //               priority: 2,
    //               title: 'Update Article',
    //               onTap: (page, _) {
    //                 sideMenu.changePage(page);
    //               },
    //               icon: const Icon(Icons.update),
    //             ),
    //             SideMenuItem(
    //               priority: 3,
    //               title: 'View Article',
    //               onTap: (page, _) {
    //                 sideMenu.changePage(page);
    //               },
    //               icon: const Icon(Icons.view_headline),
    //             ),
    //             SideMenuItem(
    //               priority: 4,
    //               title: 'Settings',
    //               onTap: (page, _) {
    //                 sideMenu.changePage(page);
    //               },
    //               icon: const Icon(Icons.settings),
    //             ),
    //             SideMenuItem(
    //               priority: 5,
    //               title: 'Exit',
    //               onTap: (page, _) {
    //                 sideMenu.changePage(page);
    //               },
    //               icon: Icon(Icons.exit_to_app),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         flex: 5,
    //         child: PageView(
    //             controller: page,
    //             children: [
    //               const DashboardPage(),
    //               const NewArticlePage(),
    //               const UpdateArticlePage(),
    //               const ReadArticlePage(),
    //               Container(
    //                 color: Colors.white,
    //                 child: const Center(
    //                   child: Text(
    //                     'Settings',
    //                     style: TextStyle(fontSize: 35),
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 color: Colors.white,
    //                 child: const Center(
    //                   child: Text(
    //                     'Are you sure ?',
    //                     style: TextStyle(fontSize: 35),
    //                   ),
    //                 ),
    //               ),
    //             ]),
    //       ),
    //     ],
    //   ),
    // );
  }
}

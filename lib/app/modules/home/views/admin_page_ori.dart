import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:heyva_web_admin/app/modules/home/views/dashboard_view.dart';
import '../../../controllers/counter_controller.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset(
            "assets/images/heyva_logo.svg",
            height: 12,
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          "Hello Admin",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: SideMenu(
              controller: sideMenu,
              style: SideMenuStyle(
                // showTooltip: false,
                displayMode: SideMenuDisplayMode.auto,
                hoverColor: Colors.deepOrange[100],
                selectedColor: Colors.deepOrange,
                selectedTitleTextStyle: const TextStyle(color: Colors.white),
                selectedIconColor: Colors.white,
              ),
              title: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              items: [
                SideMenuItem(
                  priority: 0,
                  title: 'Dashboard',
                  onTap: (page, _) {
                    debugPrint("Page: $page - Dashboard");
                    sideMenu.changePage(page);
                  },
                  icon: const Icon(Icons.home),
                ),
                SideMenuItem(
                  priority: 1,
                  title: 'New Article',
                  onTap: (page, _) {
                    debugPrint("Page: $page - New Article");
                    sideMenu.changePage(page);
                  },
                  icon: const Icon(Icons.post_add),
                  trailing: Container(
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 3),
                        child: Text(
                          'New',
                          style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                        ),
                      )),
                ),
                SideMenuItem(
                  priority: 2,
                  title: 'Update Article',
                  onTap: (page, _) {
                    debugPrint("Page: $page - Update Article");
                    sideMenu.changePage(page);
                  },
                  icon: const Icon(Icons.update),
                ),
                SideMenuItem(
                  priority: 3,
                  title: 'View Article',
                  onTap: (page, _) {
                    debugPrint("Page: $page - View Article");
                    sideMenu.changePage(page);
                  },
                  icon: const Icon(Icons.view_headline),
                ),
                SideMenuItem(
                  priority: 4,
                  title: 'Settings',
                  onTap: (page, _) {
                    debugPrint("Page: $page - Setting");
                    sideMenu.changePage(page);
                  },
                  icon: const Icon(Icons.settings),
                ),
                const SideMenuItem(
                  priority: 5,
                  title: 'Exit',
                  icon: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: PageView(
                controller: page,
                children: [
                  Container(
                    color: Colors.white,
                    child: DashboardPage(),
                    // child: const Center(
                    //   child: Text(
                    //     'Dashboard',
                    //     style: TextStyle(fontSize: 35),
                    //   ),
                    // ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'New Article',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Update Article',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'View Article',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Settings',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Are you sure ?',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

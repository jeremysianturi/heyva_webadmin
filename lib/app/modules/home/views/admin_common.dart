import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heyva_web_admin/app/modules/home/views/post_article.dart';
import 'package:heyva_web_admin/app/modules/home/views/read_article.dart';
import 'package:heyva_web_admin/app/modules/home/views/update_article.dart';
import 'package:intl/intl.dart';

import '../../../../constant/colors.dart';
import 'dashboard_view.dart';
import 'dummy_pages.dart';


// a map of ("page name", WidgetBuilder) pairs
final _availablePages = <String, WidgetBuilder>{
  'Dashboard': (_) => DashboardPage(),
  'New Article': (_) => const CreateArticlePage(),
  'Update Article': (_) => UpdateArticlePage(),
  'View Article': (_) => ViewArticlePage(),
  'Setting': (_) => const SettingPage(),
  'Logout': (_) => const ExitPage(),
};

// a map of ("page name", WidgetBuilder) pairs
final _menuPageIcons = <String, String>{
  'Dashboard': 'assets/icons/menu_dashbord.svg',
  'New Article': 'assets/icons/menu_tran.svg',
  'Update Article': 'assets/icons/menu_task.svg',
  'View Article': 'assets/icons/menu_doc.svg',
  'Setting': 'assets/icons/menu_setting.svg',
  'Logout': 'assets/images/icon_exit.png',
};

// make this a `StateProvider` so we can change its value
final selectedPageNameProvider = StateProvider<String>((ref) {
  // default value
  return _availablePages.keys.first;
});

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  // watch for state changes inside selectedPageNameProvider
  final selectedPageKey = ref.watch(selectedPageNameProvider);
  // return the WidgetBuilder using the key as index
  return _availablePages[selectedPageKey]!;
});

class AdminPageMenu extends ConsumerWidget {
  const AdminPageMenu({super.key});

  void _selectPage(BuildContext context, WidgetRef ref, String pageName) {
    if (ref.read(selectedPageNameProvider.state).state != pageName) {
    // if (ref.read(selectedPageNameProvider.notifier).state != pageName) {
      ref.read(selectedPageNameProvider.state).state = pageName;
      // ref.read(selectedPageNameProvider.notifier).state = pageName;
      // dismiss the drawer of the ancestor Scaffold if we have one
      if (Scaffold.maybeOf(context)?.hasDrawer ?? false) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. watch the provider's state
    // final selectedPageName = ref.watch(selectedPageNameProvider.state).state;
    final selectedPageName = ref.watch(selectedPageNameProvider.state).state;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: SvgPicture.asset(
                "assets/images/heyva_logo.svg",
              ),
            ),
            for(var pageName in _availablePages.keys)
              DrawerListTile(
                // 3. pass the selectedPageName as an argument
                // title: selectedPageName,
                selectedMenu: selectedPageName,
                title: pageName,
                svgSrc: _menuPageIcons[pageName].toString(),
                isSvg: _menuPageIcons[pageName].toString().endsWith("svg") ? true : false,
                press: () => _selectPage(context, ref, pageName),
              ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({Key? key, required this.selectedMenu, required this.title, required this.svgSrc, this.isSvg = true, required this.press}) : super(key: key);

  final String selectedMenu;
  final String title, svgSrc;
  final bool isSvg;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: isSvg ?
      SvgPicture.asset(
        svgSrc,
        color: selectedMenu == title ? ColorApp.btn_pink : Colors.black,
        height: 16,
      )
          : Image.asset(
        svgSrc,
        color: selectedMenu == title ? ColorApp.btn_pink : Colors.black,
        height: 16,
      ),
      horizontalTitleGap: 0.2,
      title: Text(
        title,
        style: selectedMenu == title ?
          const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorApp.btn_pink,
          )
          : const TextStyle(
            color: Colors.black87,
          )
      ),
    );
  }
}

class SelectDate extends StatelessWidget {
  final TextEditingController controller;
  const SelectDate({super.key, required this.controller});

  // final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    return DateTimeField(
      onChanged: (text) {
        // debugPrint("Date article: ${controller.text}");
      },
      controller: controller,
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        hintText: "YYY/MM/DD",
        hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
        fillColor: CupertinoColors.secondarySystemFill,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      format: format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    );
  }
}

class TitleField extends StatelessWidget {
  TitleField({Key? key}) : super(key: key);

  late ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      scrollController: scrollController,
      decoration: InputDecoration(
        hintText: 'Search saved article ...',
        hintStyle: const TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
        fillColor: CupertinoColors.secondarySystemFill,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(16 * 0.75),
            decoration: const BoxDecoration(
              color: ColorApp.btn_pink,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SvgPicture.asset(
              'assets/icons/Search.svg',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

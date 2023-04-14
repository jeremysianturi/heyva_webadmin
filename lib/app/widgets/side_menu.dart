import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: SvgPicture.asset(
                "assets/images/heyva_logo.svg",
              ),
            ),
            DrawerListTile(
              title: 'Dashboard',
              svgSrc: 'assets/icons/menu_dashbord.svg',
              press: () => { },
              // press: () { },
            ),
            DrawerListTile(
              title: 'New Article',
              svgSrc: 'assets/icons/menu_tran.svg',
              press: () { },
            ),
            DrawerListTile(
              title: 'Update Article',
              svgSrc: 'assets/icons/menu_task.svg',
              press: () { },
            ),
            DrawerListTile(
              title: 'View Article',
              svgSrc: 'assets/icons/menu_doc.svg',
              press: () { },
            ),
            DrawerListTile(
              title: 'Setting',
              svgSrc: 'assets/icons/menu_setting.svg',
              press: () { },
            ),
            DrawerListTile(
              title: 'Exit',
              isSvg: false,
              svgSrc: 'assets/images/icon_exit.png',
              press: () { },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({Key? key, required this.title, required this.svgSrc, this.isSvg = true, required this.press}) : super(key: key);

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
        color: Colors.black,
        height: 16,
      )
          : Image.asset(
        svgSrc,
        height: 16,
      ),
      horizontalTitleGap: 0.2,
      title: Text(
        title,
        style: TextStyle(color: Colors.black87),
      ),
    );
  }
}

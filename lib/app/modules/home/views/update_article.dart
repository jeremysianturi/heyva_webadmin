import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heyva_web_admin/constant/colors.dart';

import '../controllers/menu_controller.dart';
import 'admin_common.dart';


class UpdateArticlePage extends StatelessWidget {
  UpdateArticlePage({Key? key}) : super(key: key);

  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController dateEditingController = TextEditingController();
  final TextEditingController categoryEditingController = TextEditingController();
  final TextEditingController htmlEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String pageName = sideMenuItems[SideMenuItems.updateArticle.index];
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  pageName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TitleField(),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 200,
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
                    child: TextField(
                      onChanged: (text) {
                        debugPrint("Article title: ${titleEditingController.text}");
                      },
                      controller: titleEditingController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'Article title',
                        fillColor: CupertinoColors.secondarySystemFill,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
                      ),
                      cursorColor: ColorApp.grey_font,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 200,
                  child: Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextField(
                      onChanged: (text) {
                        debugPrint("Article category: ${categoryEditingController.text}");
                      },
                      controller: categoryEditingController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'Article category',
                        fillColor: CupertinoColors.secondarySystemFill,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
                      ),
                      cursorColor: ColorApp.grey_font,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 200,
                  child: Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: SelectDate(controller: dateEditingController,),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Center(
              child: Container(
                height: 400,
                width: width / 2,
                color: Colors.black,
                child: const Text(
                  "\nPhoto",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              height: 600,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              // color: ColorApp.grey_divider,
              child: TextField(
                onChanged: (text) {
                  debugPrint("Article html: ${htmlEditingController.text}");
                },
                controller: htmlEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Article content [html]',
                  fillColor: CupertinoColors.secondarySystemFill,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
                ),
                cursorColor: Colors.black,
                maxLines: 1000,
                style: const TextStyle(color: ColorApp.grey_font),
                // expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:heyva_web_admin/constant/colors.dart';

import '../controllers/menu_controller.dart';


class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController dateEditingController = TextEditingController();
  final TextEditingController categoryEditingController = TextEditingController();
  final TextEditingController htmlEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String pageName = sideMenuItems[SideMenuItems.dashboard.index];
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
            const SizedBox(height: 20,),
            SizedBox(
              height: 400,
              width: double.infinity,
              // color: Colors.black,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(color: Colors.black,),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Container(color: Colors.black,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
              color: ColorApp.grey_divider,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SvgPicture.asset(
              'assets/icons/Search.svg',
              color: Colors.black,
            ),
          ),
        ),
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
        debugPrint("Date article: ${controller.text}");
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


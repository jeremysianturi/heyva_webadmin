import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heyva_web_admin/constant/colors.dart';


class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  late TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return CustomScrollView(
    //   slivers: [
    //     SliverGrid.count(
    //       crossAxisCount: 1,
    //       childAspectRatio: 3,
    //       children: [
    //         GestureDetector(
    //           onTap: () {},
    //           child: Container(
    //             // height: 120,
    //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //             child: Container(
    //               color: Colors.grey[400],
    //               child: const Center(
    //                 child: Text("Dasboard"),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     SliverGrid.count(
    //       crossAxisCount: 2,
    //       mainAxisSpacing: 5.0,
    //       crossAxisSpacing: 5.0,
    //       childAspectRatio: 2,
    //       children: [
    //         GestureDetector(
    //           onTap: () {},
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //             child: Container(
    //               color: Colors.grey[400],
    //               child: const Center(
    //                 child: Text("Dasboard"),
    //               ),
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {},
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //             child: Container(
    //               color: Colors.grey[400],
    //               child: const Center(
    //                 child: Text("Dasboard"),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     SliverGrid.count(
    //       crossAxisCount: 1,
    //       childAspectRatio: 8,
    //       children: [
    //         GestureDetector(
    //           onTap: () {},
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //             child: Container(
    //               color: Colors.grey[400],
    //               child: const Center(
    //                 child: Text("Dasboard"),
    //               ),
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {},
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //             child: Container(
    //               color: Colors.grey[400],
    //               child: const Center(
    //                 child: Text("Dasboard"),
    //               ),
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {},
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //             child: Container(
    //               color: Colors.grey[400],
    //               child: const Center(
    //                 child: Text("Dasboard"),
    //               ),
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {},
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //             child: Container(
    //               color: Colors.grey[400],
    //               child: const Center(
    //                 child: Text("Dasboard"),
    //               ),
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {},
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //             child: Container(
    //               color: Colors.grey[400],
    //               child: const Center(
    //                 child: Text("Dasboard"),
    //               ),
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {},
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //             child: Container(
    //               color: Colors.grey[400],
    //               child: const Center(
    //                 child: Text("Dasboard"),
    //               ),
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {},
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //             child: Container(
    //               color: Colors.grey[400],
    //               child: const Center(
    //                 child: Text("Dasboard"),
    //               ),
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {},
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //             child: Container(
    //               color: Colors.grey[400],
    //               child: const Center(
    //                 child: Text("Dasboard"),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    // ]);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Article',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                Expanded(
                  // child: TextField(
                  //   decoration: InputDecoration(
                  //     fillColor: CupertinoColors.secondarySystemFill,
                  //     filled: true,
                  //     border: const OutlineInputBorder(
                  //       borderSide: BorderSide.none,
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(10),
                  //       ),
                  //     ),
                  //     suffixIcon: InkWell(
                  //       onTap: () {},
                  //       child: Container(
                  //         padding: const EdgeInsets.all(16 * 0.75),
                  //         decoration: const BoxDecoration(
                  //           color: ColorApp.grey_divider,
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(10),
                  //           ),
                  //         ),
                  //         child: SvgPicture.asset(
                  //           'assets/icons/Search.svg',
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  child: TitleField(),
                ),
              ],
            ),
            Container(
              height: 600,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              color: ColorApp.grey_divider,
              child: TextField(
                controller: editingController,
                // contextMenuBuilder: ,
                cursorColor: Colors.black,
                maxLines: 1000,
                style: TextStyle(color: ColorApp.black_font),
                // expands: true,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 400,
              width: double.infinity,
              // color: Colors.black,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(color: Colors.black,),
                  ),
                  SizedBox(width: 10,),
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
        hintText: 'Title',
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

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constant/colors.dart';
import '../services/create_client.dart';


class SelectDate extends StatelessWidget {
  final TextEditingController controller;
  const SelectDate({super.key, required this.controller});
  static CreateController createCtrl = Get.find<CreateController>();

  // final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    return SizedBox(
      height: 40,
      child: DateTimeField(
        onChanged: (text) {
          createCtrl.updateReadiness();
        },
        controller: controller,
        style: const TextStyle(fontSize: 14),
        cursorColor: Colors.black,
        decoration: const InputDecoration(
          hintText: "YYY/MM/DD",
          hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
          contentPadding: EdgeInsets.only(left: 10, top: 20),
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

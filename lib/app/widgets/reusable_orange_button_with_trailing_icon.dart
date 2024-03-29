import 'package:flutter/material.dart';
import '../../constant/colors.dart';

class OrangeButtonWTrailingIcon extends StatelessWidget {
  OrangeButtonWTrailingIcon({
    Key? key,
    required this.text,
    this.onTap,
    this.padding = 0,
  }) : super(key: key);

  final String text;
  final Function? onTap;
  double padding;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1,child: Container()),
        Expanded(flex: 1,child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  onTap!();
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(ColorApp.btn_orange),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      side: BorderSide(color: ColorApp.btn_orange),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                            color: ColorApp.arrow_white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      const ImageIcon(
                        AssetImage("assets/images/ic_arrow_right.png"),
                        color: ColorApp.arrow_white,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              )
            ],
          ),
        ),),
        Expanded(flex: 1,child: Container()),
      ],
    );
  }
}

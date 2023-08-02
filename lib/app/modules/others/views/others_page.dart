import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:heyva_web_admin/app/controllers/counter_controller.dart';


class OthersView extends StatelessWidget {
  final CounterController _counterController = Get.find();
  OthersView({super.key});

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
          "Overview",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              // color: Colors.grey,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              // color: Colors.blue,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Scaffold(
                body: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(child: Text('Clicks: ${_counterController.counter.value}')),
                    const SizedBox(height: 10,),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          // Get.offAllNamed(Routes.HOME);
                        },
                        child: const Text('Back to Home'),
                      ),
                    ),
                  ],
                )),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {_counterController.increment();},
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
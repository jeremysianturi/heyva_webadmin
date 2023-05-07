import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'admin_common.dart';

class HomeViewAdmin extends ConsumerWidget {
  const HomeViewAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. watch selectedPageBuilderProvider
    final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);

    return AdminPageLayout(
      menu: const AdminPageMenu(),
      content: selectedPageBuilder(context),
    );
  }
}


class AdminPageLayout extends StatelessWidget {
  const AdminPageLayout({Key? key, required this.menu, required this.content}) : super(key: key);

  final Widget menu;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
              child: menu,
            ),
            Expanded(
              flex: 5,
              child: content,
              // child: Container(
              //   color: Colors.white,
              //   // child: DashboardPage(),
              //   child: content,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

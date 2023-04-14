import 'package:flutter/material.dart';


class ReadArticlePage extends StatelessWidget {
  const ReadArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          SliverGrid.count(
            crossAxisCount: 1,
            childAspectRatio: 3,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  // height: 120,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Center(
                      child: Text("View Article"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 2,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Center(
                      child: Text("View Article"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Center(
                      child: Text("View Article"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverGrid.count(
            crossAxisCount: 1,
            childAspectRatio: 8,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Center(
                      child: Text("View Article"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Center(
                      child: Text("View Article"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Center(
                      child: Text("View Article"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Center(
                      child: Text("View Article"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Center(
                      child: Text("View Article"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Center(
                      child: Text("View Article"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Center(
                      child: Text("View Article"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Center(
                      child: Text("View Article"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]);
  }
}

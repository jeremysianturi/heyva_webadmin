import 'package:flutter/material.dart';


class NewArticlePage extends StatelessWidget {
  const NewArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          SliverGrid.count(
            crossAxisCount: 1,
            childAspectRatio: 10,
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter the title',
                    ),
                  ),
                ),
              ),
            ]
          ),
          SliverGrid.count(
              crossAxisCount: 1,
              childAspectRatio: 2,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Type the article here ...',
                      ),
                    ),
                  ),
                ),
              ]
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          //   child: TextFormField(
          //     decoration: const InputDecoration(
          //       border: UnderlineInputBorder(),
          //       labelText: 'Enter your username',
          //     ),
          //   ),
          // ),
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
                      child: Text("New Article"),
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
                      child: Text("New Article"),
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
                      child: Text("New Article"),
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
                      child: Text("New Article"),
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
                      child: Text("New Article"),
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
                      child: Text("New Article"),
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
                      child: Text("New Article"),
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
                      child: Text("New Article"),
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
                      child: Text("New Article"),
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
                      child: Text("New Article"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]);
  }
}

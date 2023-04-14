import 'package:flutter/material.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 120,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  )
              ),
              child: Center(
                child: Text("Dasboard"),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 120,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              )
            ),
            child: Center(
              child: Text("Dasboard"),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 120,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                )
            ),
            child: Center(
              child: Text("Dasboard"),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 120,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                )
            ),
            child: Center(
              child: Text("Dasboard"),
            ),
          ),
        ),
      ],
    );
  }
}

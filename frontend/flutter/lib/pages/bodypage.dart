import 'package:flutter/material.dart';

import 'package:zenith/pages/homepage.dart';
import 'package:zenith/utils/getrequest.dart';
import 'package:zenith/utils/getuser.dart';

class body_page extends StatefulWidget {
  const body_page({super.key});

  @override
  State<body_page> createState() => _body_pageState();
}

class _body_pageState extends State<body_page> {
  int _selectedPage = 0;

  final _pageOptions = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
    HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  // print("onpressed");
                  //  GetUser.getData();
                },
                icon: Icon(Icons.account_circle),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'data_list_page/data_list_page.dart';
import 'menu_page/food_day_menu_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    FoodDayMenuPage(),//メニュー
    DataListPage(),//登録データ一覧

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance),
                title: Text('メニュー',
//                    style: TextStyle(fontFamily: boldFont)
                )),

            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text('データ一覧',
//                    style: TextStyle(fontFamily: boldFont)
                )),

          ],
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
        body: _pages[_currentIndex],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex= index;
    });
  }
}

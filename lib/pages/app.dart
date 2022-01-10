import 'package:flutter/material.dart';
// import 'package:flutter_carrot_market/pages/favorite.dart';
import 'package:flutter_svg/svg.dart';

import 'favorite.dart';
import 'home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }

  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return const Home();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      case 4:
        return const MyFavoriteContents();
    }

    return Container();
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: (int index) {
          // print('current Index => $index');
          // 동기화 해야 처리됨.
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedFontSize: 12,
        selectedItemColor: Colors.black,
        // selectedLabelStyle: const TextStyle(color: Colors.black),
        items: <BottomNavigationBarItem>[
          _bottomNavigationBarItem("home", "홈"),
          _bottomNavigationBarItem("notes", "거래목록"),
          // _bottomNavigationBar("location", "내 근처"),
          _bottomNavigationBarItem("chat", "채팅"),
          _bottomNavigationBarItem("user", "My D-Coin"),
        ]);
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconName}_off.svg",
            width: 22,
          ),
        ),
        activeIcon: SvgPicture.asset(
          "assets/svg/${iconName}_on.svg",
          width: 22,
        ),
        label: label);
  }
}

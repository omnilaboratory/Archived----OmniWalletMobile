import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/view/main_view/home/home_page.dart';
import 'package:wallet_app/view/main_view/market_page.dart';
import 'package:wallet_app/view/main_view/my_page.dart';
import 'package:wallet_app/view/main_view/omni_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  TabController controller;
  List<Tab> tabs=[
    Tab(text: '钱包',icon: Icon(Icons.home,)),
    Tab(text: '市场',icon: Icon(Icons.filter_drama)),
    Tab(text: 'OmniDe',icon: Icon(Icons.wb_sunny)),
    Tab(text: '我的',icon: Icon(Icons.my_location)),
  ];

  int _currentIndex = 0;
  final _bottomNavigationColor = Colors.grey;
  final _bottomNavigationActiveColor = Colors.blue;
  List<Widget> pages = List();

  @override void initState() {
    super.initState();
    pages..add(HomePage())
      ..add(MarketPage())
      ..add(OmniPage())
      ..add(UserCenter());
    controller = TabController(length: 4, vsync: this);
  }

  List<BottomNavigationBarItem>  bulidTabBars(){
    List<BottomNavigationBarItem> list = [];
    list.add(BottomNavigationBarItem(
        backgroundColor: Color(0xffEAEAEA),
        icon: Icon(
          Icons.home,
          color: _bottomNavigationColor,
        ),
        activeIcon: Icon(
          Icons.home,
          color: _bottomNavigationActiveColor,
        ),
        title: Text(
          '钱包',
          style: TextStyle(color: _bottomNavigationColor),
        )));
    list.add(BottomNavigationBarItem(
        backgroundColor: Color(0xffEAEAEA),
        icon: Icon(
          Icons.filter_drama,
          color: _bottomNavigationColor,
        ),
        activeIcon: Icon(
          Icons.filter_drama,
          color: _bottomNavigationActiveColor,
        ),
        title: Text(
          '市场',
          style: TextStyle(color: _bottomNavigationColor),
        )));
    list.add(BottomNavigationBarItem(
        backgroundColor: Color(0xffEAEAEA),
        icon: Icon(
          Icons.pages,
          color: _bottomNavigationColor,
        ),
        activeIcon: Icon(
          Icons.pages,
          color: _bottomNavigationActiveColor,
        ),
        title: Text(
          'OmniDe',
          style: TextStyle(color: _bottomNavigationColor),
        )));
    list.add(BottomNavigationBarItem(
        backgroundColor: Color(0xffEAEAEA),
        icon: Icon(
          Icons.my_location,
          color: _bottomNavigationColor,
        ),
        activeIcon: Icon(
          Icons.my_location,
          color: _bottomNavigationActiveColor,
        ),
        title: Text(
          '我的',
          style: TextStyle(color: _bottomNavigationColor),
        )));
    return list;
  }



  @override void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        bottomNavigationBar: BottomNavigationBar(
//          items: bulidTabBars(),
//          currentIndex: _currentIndex,
//          onTap: (int index) {
//            setState(() {
//              _currentIndex = index;
//            });
//          },
//          type: BottomNavigationBarType.fixed,
//          iconSize: 20,
//        ),
//      body: pages[_currentIndex],
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
            indicatorWeight: 1,
            controller: controller,
            tabs:tabs),
      ),
      body: TabBarView(
          controller: controller,
          children: this.pages
      ),
    );
  }
}

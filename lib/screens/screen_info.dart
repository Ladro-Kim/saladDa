import 'package:flutter/material.dart';
import 'package:salad_da/screens/screen_news.dart';
import 'package:salad_da/screens/screen_weather.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with TickerProviderStateMixin {
  TabController _tabController;

  List<Tab> tabs = [
    Tab(
      child: Text(
        "Weather",
        style: TextStyle(color: Colors.black87),
      ),
    ),
    Tab(
      child: Text(
        "Today's Hot",
        style: TextStyle(color: Colors.black87),
      ),
    ),
  ];

  List<Widget> pages = [
    WeatherScreen(),
    NewsScreen(),
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: buildTabBar(),
      body: TabBarView(
        controller: _tabController,
        children: pages,
      ),
    );
  }

  Widget buildTabBar() {
    return TabBar(
      unselectedLabelStyle: TextStyle(color: Colors.black),
      indicator: BoxDecoration(
        color: Colors.white,
      ),
      overlayColor: MaterialStateProperty.all(Colors.orangeAccent),
      controller: _tabController,
      tabs: tabs,
      onTap: (index) {},
    );
  }
}

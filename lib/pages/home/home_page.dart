import 'package:cash_book_app4/pages/home/dashboard_page.dart';
import 'package:cash_book_app4/pages/home/sales_page.dart';
import 'package:cash_book_app4/pages/home/settings_page.dart';
import 'package:cash_book_app4/utils/dimentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../utils/appcolors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [SalesPage(), DashboardPage(), SettingsPage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/expense.png", // Path to your image asset
          width: 50, // Width of the image
          height: 50, // Height of the image
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/revenue.png",
          width: 50, // Width of the image
          height: 50, // Path to your image asset
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/personSettings.png", // Path to your image asset
          width: 50, // Width of the image
          height: 50, // Height of the image
        ),
      ),
    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      navBarHeight: Dimentions.height30 * 2.5,
      margin: EdgeInsets.only(
          left: Dimentions.width5,
          right: Dimentions.width5,
          bottom: Dimentions.width5),
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColors.mainColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(Dimentions.radius15),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}

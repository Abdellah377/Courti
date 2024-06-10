import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kourti_application_1/app_localizations.dart';
import 'package:kourti_application_1/home/Users/AllUsers.dart';
import 'package:kourti_application_1/home/Annonces/Annonce.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PersistentNavBarScreen extends StatefulWidget {
  const PersistentNavBarScreen({super.key});

  @override
  State<PersistentNavBarScreen> createState() => _PersistentNavBarScreenState();
}

class _PersistentNavBarScreenState extends State<PersistentNavBarScreen> {
  late PersistentTabController _controller;
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    _controller = PersistentTabController(initialIndex: _selectedIndex);
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      const Annonce(),
      const AllUsers(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Courti"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.rectangle_stack_person_crop),
        title: AppLocalizations.of(context)!.translate('Users')!,
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, 
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true, 
      stateManagement: true, 
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:NavBarStyle.style2,
      hideNavigationBar: _selectedIndex == 0 ? null : true, // Hide navigation bar for unselected pages
    );
  }
}

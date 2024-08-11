import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:negmt_heliopolis/core/constants/colors.dart';
import 'package:negmt_heliopolis/core/models/language/app_localizations.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());

    return Scaffold(
      // appBar: AppBar(),
      body: const Center(child: Text('hello from home')),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 10, // Blur radius
              offset: const Offset(0, 4), // Shadow position (x, y)
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            selectedIndex: _selectedIndex,
            padding: const EdgeInsets.all(16),
            gap: 8,
            backgroundColor: Colors.white,
            color: MyColors.mainColor,
            activeColor: Colors.white,
            tabBackgroundColor: MyColors.mainColor,
            onTabChange: (index) {
              setState(() {
                if (_selectedIndex != index) {
                  _selectedIndex = index;
                }
              });
            },
            tabs: [
              _buttonItem(
                activeIcon: Icons.home,
                outlinedIcon: Icons.home_outlined,
                index: 0,
                text: 'home'.tr(context),
              ),
              _buttonItem(
                activeIcon: Icons.search,
                outlinedIcon: Icons.search_outlined,
                index: 1,
                text: 'search'.tr(context),
              ),
              _buttonItem(
                activeIcon: Icons.favorite,
                outlinedIcon: Icons.favorite_border_outlined,
                index: 2,
                text: 'Liked'.tr(context),
              ),
              _buttonItem(
                activeIcon: FontAwesomeIcons.cartArrowDown,
                // outlinedIcon: Icons.inventory_2_outlined,
                index: 3,
                text: 'cart'.tr(context),
              ),
              _buttonItem(
                activeIcon: Icons.person,
                outlinedIcon: Icons.person_outline,
                index: 4,
                text: 'profile'.tr(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GButton _buttonItem({
    required IconData activeIcon,
    IconData? outlinedIcon,
    required String text,
    required int index,
  }) {
    outlinedIcon ??= activeIcon;
    return GButton(
      icon: _selectedIndex == index ? activeIcon : outlinedIcon,
      text: text,
      padding: const EdgeInsets.all(10),
      gap: 10,
    );
  }
}

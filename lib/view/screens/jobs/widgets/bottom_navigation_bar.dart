import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rize/controller/theme/colors.dart';


  Container buildBottomNavigationBar(selectedIndex,onTabChange) {
    return Container(
      color: ColorsManager.mainBlue,
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 40, left: 30, right: 30, top: 16),
        child: GNav(
          backgroundColor: Colors.transparent,
          tabBackgroundColor: Colors.white,
          tabBorderRadius: 50,
          padding: const EdgeInsets.all(10),
          gap: 8,
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
          tabs: const [
            GButton(
              icon: Icons.work,
              text: 'Jobs',
              iconColor: Colors.white,
              iconActiveColor: ColorsManager.mainBlue,
              textStyle: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                color: ColorsManager.mainBlue,
              ),
            ),
            GButton(
              icon: Icons.post_add,
              text: 'Post Job',
              iconColor: Colors.white,
              iconActiveColor: ColorsManager.mainBlue,
              textStyle: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                color: ColorsManager.mainBlue,
              ),
            ),
            GButton(
              icon: Icons.details,
              text: 'Job Details',
              iconColor: Colors.white,
              iconActiveColor: ColorsManager.mainBlue,
              textStyle: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                color: ColorsManager.mainBlue,
              ),
            ),
            GButton(
              icon: Icons.search,
              text: 'Search Jobs',
              iconColor: Colors.white,
              iconActiveColor: ColorsManager.mainBlue,
              textStyle: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                color: ColorsManager.mainBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
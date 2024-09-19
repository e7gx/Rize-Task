import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rize/controller/theme/colors.dart';
import 'package:rize/controller/theme/styles.dart';

Container buildBottomNavigationBar(selectedIndex, onTabChange) {
  return Container(
    color: ColorsManager.mainBlue,
    child: Padding(
      padding:
          EdgeInsets.only(bottom: 40.h, left: 30.w, right: 30.w, top: 16.h),
      child: GNav(
        backgroundColor: Colors.transparent,
        tabBackgroundColor: Colors.white,
        tabBorderRadius: 50,
        padding: const EdgeInsets.all(10),
        gap: 8,
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
        tabs: [
          GButton(
            icon: Icons.work,
            text: 'Jobs',
            iconColor: Colors.white,
            iconActiveColor: ColorsManager.mainBlue,
            textStyle: TextStyles.font14Bluebold,
          ),
          GButton(
            icon: Icons.post_add,
            text: 'Post Job',
            iconColor: Colors.white,
            iconActiveColor: ColorsManager.mainBlue,
            textStyle: TextStyles.font14Bluebold,
          ),
          GButton(
            icon: Icons.delete,
            text: 'Delete Job',
            iconColor: Colors.white,
            iconActiveColor: ColorsManager.mainBlue,
            textStyle: TextStyles.font14Bluebold,
          ),
          GButton(
            icon: Icons.search,
            text: 'Search Jobs',
            iconColor: Colors.white,
            iconActiveColor: ColorsManager.mainBlue,
            textStyle: TextStyles.font14Bluebold,
          ),
          GButton(
            icon: Icons.memory,
            text: 'Assistant',
            iconColor: Colors.white,
            iconActiveColor: ColorsManager.mainBlue,
            textStyle: TextStyles.font14Bluebold,
          ),
        ],
      ),
    ),
  );
}

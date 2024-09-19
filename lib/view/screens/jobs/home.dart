import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rize/chat/chat.dart';
import 'package:rize/controller/helpers/extentions.dart';
import 'package:rize/controller/theme/colors.dart';
import 'package:rize/view/screens/jobs/add_job_screen.dart';
import 'package:rize/view/screens/jobs/job_delete_screen.dart';
import 'package:rize/view/screens/jobs/job_list_screen.dart';
import 'package:rize/view/screens/jobs/search_job_screen.dart';
import 'package:rize/view/screens/jobs/widgets/bottom_navigation_bar.dart';
import 'package:rize/view/screens/jobs/widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final String firstName = 'Abdullah';

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const JobListScreen(),
      const AddJobScreen(),
      const JobDeleteScreen(),
      const SearchJobScreen(),
      const AiChatPage(),
    ];

    return Scaffold(
      appBar: buildAppBar(firstName),
      endDrawer: buildDrawer(context, onDrawerItemTapped),
      body: pages[selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(selectedIndex, onTabChange),
    );
  }

  void onTabChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onDrawerItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    context.pop();
  }
}

Drawer buildDrawer(BuildContext context, Function(int) onTap) {
  return Drawer(
    child: Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: ColorsManager.mainBlue,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 80.h,
                ),
              ],
            ),
          ),
          _buildDrawerDivider(),
          _buildDrawerItem(context, 'Add Job', Icons.add, onTap, 0),
          _buildDrawerDivider(),
          _buildDrawerItem(context, 'Job List', Icons.list, onTap, 1),
          _buildDrawerDivider(),
          _buildDrawerItem(context, 'Job Delete', Icons.delete, onTap, 2),
          _buildDrawerDivider(),
          _buildDrawerItem(context, 'Search Job', Icons.search, onTap, 3),
          _buildDrawerDivider(),
          _buildDrawerItem(context, 'Chat', Icons.chat, onTap, 4),
          _buildDrawerDivider(),
          _buildDrawerItem(context, 'Logout', Icons.logout, onTap, -1,
              isLogout: true),
        ],
      ),
    ),
  );
}

Widget _buildDrawerDivider() {
  return Divider(
    color: Colors.grey.shade100,
    thickness: 12.h,
  );
}

Widget _buildDrawerItem(BuildContext context, String title, IconData icon,
    Function(int) onTap, int index,
    {bool isLogout = false}) {
  return Container(
    color: Colors.white,
    child: ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : ColorsManager.mainBlue,
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
          fontSize: 13.sp,
          color: isLogout ? ColorsManager.redAccent : ColorsManager.mainBlue,
        ),
      ),
      onTap: () {
        if (isLogout) {
          
        } else {
          onTap(index);
        }
      },
    ),
  );
}

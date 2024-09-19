import 'package:flutter/material.dart';
import 'package:rize/chat/chat.dart';
import 'package:rize/view/screens/jobs/add_job_screen.dart';

import 'package:rize/view/screens/jobs/job_detail_screen.dart';
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
      const AddJobScreen(),
      const JobListScreen(),
      const JobDeleteScreen(),
      const SearchJobScreen(),
      const AiChatPage(),
    ];

    return Scaffold(
      appBar: buildAppBar(firstName),
      body: pages[selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(selectedIndex, onTabChange),
    );
  }

  void onTabChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

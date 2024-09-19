// view/screens/jobs/job_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rize/controller/theme/styles.dart';
import 'package:rize/model/jobs_model.dart';
import 'package:rize/view/screens/jobs/widgets/job_card.dart';
import 'package:rize/view/screens/onboarding/widgets/stackui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  List<Job> _jobs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadJobs();
  }

  Future<void> loadJobs() async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jobsString = prefs.getString('jobs');
    List<dynamic> jobsList = jobsString != null ? json.decode(jobsString) : [];

    setState(() {
      _jobs = jobsList.map((jobData) => Job.fromJson(jobData)).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animation/Search.json',
                    width: 300.w,
                    height: 300.h,
                  ),
                  Text(
                    'Loading jobs...',
                    style: TextStyles.font28BlueBold,
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: loadJobs,
              child: Stack(
                children: [
                  stackBacground(),
                  ListView.builder(
                    padding: EdgeInsets.all(0.w),
                    itemCount: _jobs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: JobCard(job: _jobs[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

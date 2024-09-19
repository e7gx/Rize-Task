import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rize/controller/helpers/jobs/job_uilts.dart';
import 'package:rize/controller/theme/colors.dart';
import 'package:rize/controller/theme/styles.dart';
import 'package:rize/model/jobs_model.dart';
import 'package:rize/view/screens/jobs/widgets/job_card.dart';
import 'package:rize/view/screens/onboarding/widgets/stackui.dart';

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
    loadListofJobs();
  }

  Future<void> loadListofJobs() async {
    setState(() {
      _isLoading = true;
    });

    _jobs = await loadJobs();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animation/Search.json',
                      width: 300.w,
                      height: 300.h,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Loading jobs...',
                      style: TextStyles.font28BlueBold,
                    ),
                  ],
                ),
              ),
            )
          : _jobs.isEmpty
              ? Center(
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/animation/x.json',
                          width: 300.w,
                          height: 300.h,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'No jobs available',
                          style: TextStyles.font28BlueBold,
                        ),
                      ],
                    ),
                  ),
              )
              : RefreshIndicator(
                  backgroundColor: ColorsManager.mainBlue,
                  color: Colors.white,
                  onRefresh: loadListofJobs,
                  child: Stack(
                    children: [
                      stackBacground(),
                      ListView.builder(
                        padding: EdgeInsets.all(0.w),
                        itemCount: _jobs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(12.h),
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


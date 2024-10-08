import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:rize/controller/helpers/alerts/snackbar.dart';
import 'package:rize/controller/helpers/extentions.dart';
import 'package:rize/controller/theme/colors.dart';
import 'package:rize/controller/theme/styles.dart';
import 'package:rize/view/screens/jobs/widgets/ads_card.dart';
import 'package:rize/view/screens/jobs/widgets/custom_jobs_card.dart';
import 'package:rize/view/screens/jobs/widgets/search_for_job.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SearchJobScreen extends StatefulWidget {
  const SearchJobScreen({super.key});

  @override
  SearchJobScreenState createState() => SearchJobScreenState();
}

class SearchJobScreenState extends State<SearchJobScreen> {
  final _pageController = PageController();
  List<Map<String, dynamic>> _jobs = [];
  List<Map<String, dynamic>> _filteredJobs = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadJobs();
    _searchController.addListener(() {
      _filterJobs(_searchController.text);
    });
  }

  Future<void> _loadJobs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jobsString = prefs.getString('jobs');
      if (jobsString != null) {
        List<dynamic> jobsList = json.decode(jobsString);
        setState(() {
          _jobs = List<Map<String, dynamic>>.from(jobsList.map((job) {
            return job is Map<String, dynamic> ? job : json.decode(job);
          }));
          _filteredJobs = _jobs; // Initialize filtered jobs with all jobs
        });
      } else {
        // print("No jobs found in SharedPreferences.");
      }
    } catch (e) {
      // print("Error loading jobs: $e");
    }
  }

  void _filterJobs(String query) {
    setState(() {
      _filteredJobs = _jobs.where((job) {
        return job['title'].toLowerCase().contains(query.toLowerCase()) ||
            job['company'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  String _formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => card2(),
                    itemCount: 3,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: const SwapEffect(
                  dotHeight: 10,
                  radius: 30,
                  dotColor: Colors.grey,
                  activeDotColor: ColorsManager.mainBlue,
                  spacing: 10,
                ),
              ),
              SearchInput(
                textController: _searchController,
                hintText: 'Type to search for jobs...',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: _filteredJobs.isEmpty
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
                                'No jobs by this name',
                                style: TextStyles.font28BlueBold,
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredJobs.length,
                        itemBuilder: (context, index) {
                          final job = _filteredJobs[index];
                          return CardFb2(
                            text: job['title'],
                            subtitle: job['company'],
                            thirdText: job['location'],
                            imageUrl: 'sdsds',
                            onPressed: () {
                              _showJobDetailsBottomSheet(context, job);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showJobDetailsBottomSheet(
      BuildContext context, Map<String, dynamic> job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: ColorsManager.mainBlue,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      height: 200.h,
                      width: 200.h,
                      child: Image.asset(
                        'assets/images/job.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Position:\n${job['title'].toUpperCase()}',
                    style: TextStyles.font22DarkBlueWeight700,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: ColorsManager.lightBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Location: ${job['location'].toUpperCase()}',
                      style: TextStyles.font16BlueRegular,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: ColorsManager.lightBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Company: ${job['company'].toUpperCase()}',
                      style: TextStyles.font16BlueRegular,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Job Description:',
                    style: TextStyles.font20BlueWeight600,
                  ),
                  SizedBox(height: 8.h),
                  ReadMoreText(
                    job['description'],
                    trimMode: TrimMode.Line,
                    trimLines: 3,
                    colorClickableText: ColorsManager.mainBlue,
                    trimCollapsedText: 'more',
                    trimExpandedText: 'less',
                    moreStyle: TextStyles.font16BlueRegular,
                    lessStyle: TextStyles.font16BlueRegular,
                  ),
                  Text(
                    'Posted at: ${_formatDate(job['id'])}',
                    style: TextStyles.font13GrayRegular,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 22.h),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showSuccessNotification(context,
                          "Thank you for applying to ${job['company']}");
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(vertical: 16.h)),
                      backgroundColor:
                          WidgetStateProperty.all(ColorsManager.mainBlue),
                      minimumSize:
                          WidgetStateProperty.all(Size(double.infinity, 52.h)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                    ),
                    child: Text(
                      'Apply Now',
                      style: TextStyles.font16WhiteWeight700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

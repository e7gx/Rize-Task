import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:rize/controller/helpers/alerts/snackbar.dart';
import 'package:rize/controller/helpers/jobs/job_uilts.dart';
import 'package:rize/controller/theme/colors.dart';
import 'package:rize/controller/theme/styles.dart';
import 'package:rize/model/jobs_model.dart';
import 'package:intl/intl.dart';

class JobDeleteScreen extends StatefulWidget {
  const JobDeleteScreen({super.key});

  @override
  State<JobDeleteScreen> createState() => _JobDeleteScreenState();
}

class _JobDeleteScreenState extends State<JobDeleteScreen> {
  List<Job> _jobs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadListOfJobsInDelete();
  }

  Future<void> loadListOfJobsInDelete() async {
    setState(() {
      _isLoading = true;
    });

    _jobs = await loadJobs();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _showJobDetailsBottomSheet(
      BuildContext context, Job job, int index) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20.0.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Close Icon
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.blue),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Position: ${job.title.toUpperCase()}',
                        style: TextStyles.font22DarkBlueWeight700,
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: ColorsManager.lightBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Location: ${job.location.toUpperCase()}',
                          style: TextStyles.font16BlueRegular,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: ColorsManager.lightBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Company: ${job.company.toUpperCase()}',
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
                        job.description,
                        trimMode: TrimMode.Line,
                        trimLines: 3,
                        colorClickableText: ColorsManager.mainBlue,
                        trimCollapsedText: 'more',
                        trimExpandedText: 'less',
                        moreStyle: TextStyles.font16BlueRegular,
                        lessStyle: TextStyles.font16BlueRegular,
                      ),
                      Text(
                        'Posted at: ${formatDate(job.id)}',
                        style: TextStyles.font16BlueRegular,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 22.h),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await _deleteJob(index);
                          if (context.mounted) {
                            showDeleteAlert(context,
                                "The Job ${job.title} Has been Deleted");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.red),
                          minimumSize: WidgetStateProperty.all(
                              Size(double.infinity, 52.h)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          )),
                        ),
                        child: Text('Delete Job',
                            style: TextStyles.font16WhiteWeight700),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  Future<void> _deleteJob(int index) async {
    setState(() {
      _jobs.removeAt(index);
    });
    await saveJobs(
        _jobs); // Use the helper function to save the updated job list
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _jobs.isEmpty
              ? Center(
                  child: Text(
                    'No jobs available for deletion',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: _jobs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.only(bottom: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.w),
                        title: Text(
                          _jobs[index].title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          _jobs[index].company,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        onTap: () {
                          _showJobDetailsBottomSheet(
                              context, _jobs[index], index);
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

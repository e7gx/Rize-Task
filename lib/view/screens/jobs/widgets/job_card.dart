import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:rize/controller/helpers/extentions.dart';
import 'package:rize/controller/theme/styles.dart';
import 'package:rize/model/jobs_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rize/controller/theme/colors.dart';
import 'package:intl/intl.dart';

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showJobDetailsBottomSheet(context, job);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: 32.r,
                    backgroundImage: const AssetImage('assets/images/job.png'),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Position: ${job.title}',
                          style: TextStyles.font16BlueRegular,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Company: ${job.company}',
                          style: TextStyles.font12BlueGrayWeight400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            Container(
              width: double.infinity,
              height: 200.h,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: const DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Divider(
              color: ColorsManager.mainBlue,
              thickness: 1,
              indent: 16.w,
              endIndent: 16.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ElevatedButton.icon(
                onPressed: () {
                  _showJobDetailsBottomSheet(context, job);
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(ColorsManager.mainBlue),
                  minimumSize: WidgetStateProperty.all(
                    const Size(double.infinity, 52),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: Text(
                  'View Details',
                  style: TextStyles.font16WhiteWeight700,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text(
                  'Posted at: ${_formatDate(job.id)}',
                  style: TextStyles.font13GrayRegular,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showJobDetailsBottomSheet(BuildContext context, Job job) {
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
                mainAxisSize: MainAxisSize
                    .min, // Use min to prevent unbounded height issues
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Close Icon
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
                    'Position: ${job.title.toUpperCase()}',
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
                      'Location: ${job.location.toUpperCase()}',
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
                    'Posted at: ${_formatDate(job.id)}',
                    style: TextStyles.font16BlueRegular,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 22.h),
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                        vertical: 16.h,
                      )),
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

  String _formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}

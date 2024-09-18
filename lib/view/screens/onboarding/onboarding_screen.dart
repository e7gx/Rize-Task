import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rize/controller/theme/styles.dart';
import 'package:rize/view/screens/onboarding/widgets/rize_logo_and_name.dart';
import 'package:rize/view/screens/onboarding/widgets/rize_image_and_text.dart';
import 'package:rize/view/screens/onboarding/widgets/get_started_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 30.h,
              bottom: 30.h,
            ),
            child: Column(
              children: [
                const RizeLogoAndName(),
                SizedBox(height: 15.h),
                const DoctorImageAndText(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      Text(
                        'Find your dream job effortlessly with JobFinder, the ultimate job search app.',
                        textAlign: TextAlign.center,
                        style: TextStyles.font13GrayRegular,
                      ),
                      SizedBox(height: 30.h),
                      const GetStartedButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

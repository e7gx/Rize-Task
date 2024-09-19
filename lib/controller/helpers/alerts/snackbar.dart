import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rize/controller/theme/colors.dart';

void showSuccessNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Lottie.asset(
            'assets/animation/like1.json',
            width: 50.w,
            height: 50.h,
          ),
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(10.h),
      duration: const Duration(seconds: 3),
    ),
  );
}

void showDeleteAlert(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Lottie.asset(
            'assets/animation/like1.json',
            width: 50.w,
            height: 50.h,
          ),
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: ColorsManager.mainBlue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(10.0),
      duration: const Duration(seconds: 3),
    ),
  );
}

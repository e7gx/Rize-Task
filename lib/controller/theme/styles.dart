import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rize/controller/theme/colors.dart';

class TextStyles {
  static TextStyle font32BlueBold = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: ColorsManager.mainBlue,
  );

  static TextStyle font24BlackWeight700 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle font13GrayRegular = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: ColorsManager.gray,
  );

  static TextStyle font16WhiteWeight700 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: ColorsManager.white,
  );

  static TextStyle font20BlueWeight600 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorsManager.mainBlue,
  );

  static TextStyle font18LightBlueWeight500 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: ColorsManager.lightBlue,
  );

  static TextStyle font14DarkBlueItalic = const TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
    color: ColorsManager.darkBlue,
  );

  static TextStyle font12BlueAccentWeight400 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorsManager.blueAccent,
  );

  static TextStyle font28BlueBold = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: ColorsManager.mainBlue,
  );

  static TextStyle font24LightBlueBold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: ColorsManager.lightBlue,
  );

  static TextStyle font22DarkBlueWeight700 = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: ColorsManager.darkBlue,
  );

  // Body Text
  static TextStyle font16BlueRegular = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: ColorsManager.mainBlue,
  );

  static TextStyle font14Bluebold = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: ColorsManager.mainBlue,
  );

  static TextStyle font12BlueGrayWeight400 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorsManager.blueGray,
  );
}

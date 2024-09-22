import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rize/controller/theme/colors.dart';
import 'package:rize/controller/theme/styles.dart';

class CardFb2 extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;
  final String thirdText;
  final Function() onPressed;

  const CardFb2(
      {required this.text,
      required this.imageUrl,
      required this.subtitle,
      required this.thirdText,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(10, 20),
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.05)),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/job.png',
                    height: 59.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  ExpandIcon(
                    onPressed: (bool value) {
                      onPressed();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 80.w,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                colors: [
                                  ColorsManager.mainBlue.withOpacity(0.7),
                                  Colors.tealAccent.withOpacity(0.9),
                                ],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.business,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                SizedBox(width: 4.w),
                                FittedBox(
                                  child: Text(
                                    subtitle,
                                    style: TextStyles.font12Whitebold
                                        .copyWith(fontSize: 10.sp),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 80.w,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                colors: [
                                  ColorsManager.mainBlue.withOpacity(0.7),
                                  Colors.tealAccent.withOpacity(0.9),
                                ],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.pin_drop_outlined,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  thirdText,
                                  style: TextStyles.font12Whitebold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  const Text(
                    '3 Weeks Ago',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

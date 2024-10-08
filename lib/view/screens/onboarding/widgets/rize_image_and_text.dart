import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rize/controller/theme/styles.dart';

class RizeImageAndText extends StatelessWidget {
  const RizeImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/image.png',
          width: 1000.w,
          height: 500.h,
          color: Colors.white.withOpacity(0.5),
          colorBlendMode: BlendMode.dstIn,
        ),
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.14, 0.4],
            ),
          ),
          child: Image.asset(
            'assets/images/job.png',
            width: 5000.w,
            height: 400.h,
          ),
        ),
        Positioned(
          bottom: 15,
          left: 0,
          right: 0,
          child: Text(
            'Rize App\nFind Jobs Easily',
            textAlign: TextAlign.center,
            style: TextStyles.font32BlueBold.copyWith(
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

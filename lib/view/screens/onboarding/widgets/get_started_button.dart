import 'package:flutter/material.dart';
// import 'package:rize/controller/helpers/extentions.dart';
// import 'package:rize/controller/routing/routes.dart';
import 'package:rize/controller/theme/colors.dart';
import 'package:rize/controller/theme/styles.dart';
import 'package:rize/view/screens/jobs/home.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // context.pushReplacementNamed(Routes.homeScreen);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(ColorsManager.mainBlue),
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
      child: Text(
        'Get Started',
        style: TextStyles.font16WhiteWeight700,
      ),
    );
  }
}

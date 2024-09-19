
import 'package:flutter/material.dart';
import 'package:rize/controller/routing/routes.dart';
import 'package:rize/view/screens/jobs/add_job_screen.dart';
import 'package:rize/view/screens/jobs/home.dart';
import 'package:rize/view/screens/jobs/job_detail_screen.dart';
import 'package:rize/view/screens/jobs/job_list_screen.dart';
import 'package:rize/view/screens/jobs/search_job_screen.dart';
import 'package:rize/view/screens/onboarding/onboarding_screen.dart';
import 'package:rize/view/screens/splach_screen/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.jobListScreen:
        return MaterialPageRoute(builder: (_) => const JobListScreen());
      case Routes.addJobScreen:
        return MaterialPageRoute(builder: (_) => const AddJobScreen());
      case Routes.jobDetailScreen:
        return MaterialPageRoute(builder: (_) => const JobDeleteScreen());
      case Routes.searchJobScreen:
        return MaterialPageRoute(builder: (_) => const SearchJobScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

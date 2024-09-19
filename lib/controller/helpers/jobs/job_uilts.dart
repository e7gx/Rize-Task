import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rize/model/jobs_model.dart';

// Helper function to parse job data
Job _parseJobData(dynamic jobData) {
  if (jobData is String) {
    final Map<String, dynamic> jobMap = json.decode(jobData);
    return Job.fromJson(jobMap);
  } else if (jobData is Map<String, dynamic>) {
    return Job.fromJson(jobData);
  } else {
    throw Exception('Unexpected data format: $jobData');
  }
}

// Function to load jobs from SharedPreferences
Future<List<Job>> loadJobs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jobsString = prefs.getString('jobs');
  List<dynamic> jobsList = jobsString != null ? json.decode(jobsString) : [];
  
  return jobsList.map((jobData) => _parseJobData(jobData)).toList();
}

// Function to save jobs to SharedPreferences
Future<void> saveJobs(List<Job> jobs) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> jobStrings = jobs.map((job) => json.encode(job.toJson())).toList();
  await prefs.setString('jobs', json.encode(jobStrings));
}

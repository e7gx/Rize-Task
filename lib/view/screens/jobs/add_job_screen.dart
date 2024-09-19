import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rize/controller/theme/colors.dart';
import 'package:rize/controller/theme/styles.dart';
import 'package:rize/view/screens/jobs/widgets/text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String dropdownValueForm = citys.first;

  Future<void> saveJob() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> jobData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'company': _companyController.text,
        'location': _locationController.text,
        'id': DateTime.now().toString(),
      };

      // Fetch stored jobs
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jobsString = prefs.getString('jobs');
      List<dynamic> jobs = jobsString != null ? json.decode(jobsString) : [];

      // Add the new job
      jobs.add(jobData);

      // Save updated job list
      await prefs.setString('jobs', json.encode(jobs));

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Lottie.asset(
                  'assets/animation/like1.json',
                  width: 50.h,
                  height: 50.h,
                ),
                Text(
                  'Job posted successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyles.font16WhiteWeight700.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(10.0),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Lottie.asset(
                  'assets/animation/like1.json',
                  width: 200.h,
                  height: 150.h,
                ),
                Text(
                  'Add Job',
                  style: TextStyles.font32BlueBold,
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownMenuForm(
                    onSelected: (String value) {
                      setState(() {
                        dropdownValueForm = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                buildTextFormField(
                  prefixIcon: Icons.business,
                  controller: _companyController,
                  labelText: 'Company',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a company name';
                    } else if (!RegExp(r'^[a-zA-Z0-9].{2,}$').hasMatch(value)) {
                      return 'Company name must be at least 3 characters long and start with a letter or number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                buildTextFormField(
                  prefixIcon: Icons.work,
                  controller: _titleController,
                  labelText: 'Job Title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a job title';
                    } else if (!RegExp(r'^[a-zA-Z0-9].{2,}$').hasMatch(value)) {
                      return 'Job title must be at least 3 characters long and start with a letter or number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                buildTextFormField3Lines(
                  prefixIcon: Icons.description,
                  controller: _descriptionController,
                  labelText: 'Description',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a job description';
                    } else if (!RegExp(r'^[a-zA-Z0-9][\s\S]{2,}$')
                        .hasMatch(value)) {
                      return 'Description must be at least 3 characters long and start with a letter or number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                TextButton(
                  onPressed: () {
                    saveJob();
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
                  child: Text(
                    'Add Job',
                    style: TextStyles.font16WhiteWeight700,
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

import 'package:flutter/material.dart';

AppBar buildAppBar(String? firstName) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/test.png'),
          radius: 22,
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(width: 8),
        Text(
          'Welcome $firstName 👋',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade800,
            fontSize: 20.0,
          ),
        ),
      ],
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  );
}

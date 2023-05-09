// ignore_for_file: unnecessary_import, implementation_imports

import 'package:app/includes/custom_heading.dart';
import 'package:app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "🌤️",
              style: TextStyle(fontSize: 60),
            ),
            const SizedBox(
              height: 10,
            ),
            customHeading('Weatherquiz')
          ],
        ),
      ),
    );
  }
}

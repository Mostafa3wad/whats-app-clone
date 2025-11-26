import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusEmpty extends StatelessWidget {
  const StatusEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 43.h,
      alignment: Alignment.center,
      child: const Text(
        'No recent updates to show right now.',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}

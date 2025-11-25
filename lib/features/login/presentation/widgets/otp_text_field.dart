import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:whats_app_clone/core/constants/paths/route_names.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Pinput(
        controller: controller,
        length: 6,
        defaultPinTheme: const PinTheme(
          width: 40,
          height: 48,
          textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
        ),

        separatorBuilder: (int index) {
          if (index == 2) {
            return SizedBox(width: 24.w);
          }
          return const SizedBox(width: 12);
        },
        onCompleted: (String value) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.home,
            (Route<dynamic> route) => false,
          );
        },
      ),
    );
  }
}

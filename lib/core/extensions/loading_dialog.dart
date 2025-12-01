import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/widgets/custom_loading.dart';

extension Dialog on BuildContext {
  void loadingDialog({required BuildContext context, Color? doneColor}) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: SizedBox(height: 200.h, child: const CustomLoading()),
      ),
    );
  }
}

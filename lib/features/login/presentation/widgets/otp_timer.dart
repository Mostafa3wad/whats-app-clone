import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';

class OtpTimer extends StatefulWidget {
  const OtpTimer({super.key, this.onResendPressed, this.initialSeconds = 119});

  final VoidCallback? onResendPressed;
  final int initialSeconds;

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _remainingSeconds = widget.initialSeconds;
    });
    _startTimer();
  }

  String get _formattedTime {
    final int minutes = _remainingSeconds ~/ 60;
    final int seconds = _remainingSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_remainingSeconds > 0) {
      return Text(
        'Resend code in $_formattedTime',
        style: AppStyles.b1Blod.copyWith(color: Colors.grey),
      );
    }

    return TextButton(
      onPressed: () {
        widget.onResendPressed?.call();
        _resetTimer();
      },
      child: Text(
        'Resend OTP Code',
        style: AppStyles.b1Blod.copyWith(color: AppColors.primary),
      ),
    );
  }
}

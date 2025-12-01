import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/core/constants/paths/route_names.dart';
import 'package:whats_app_clone/core/extensions/loading_dialog.dart';
import 'package:whats_app_clone/core/extensions/open_dialog.dart';
import 'package:whats_app_clone/core/extensions/show_snackbar.dart';
import 'package:whats_app_clone/features/login/presentation/cubit/login_cubit.dart';
import 'package:whats_app_clone/features/login/presentation/widgets/otp_rich_text.dart';
import 'package:whats_app_clone/features/login/presentation/widgets/otp_text_field.dart';
import 'package:whats_app_clone/features/login/presentation/widgets/otp_timer.dart';

class OtpPageArguments {
  final String phoneNumber;
  final String sessionId;

  OtpPageArguments({required this.phoneNumber, required this.sessionId});
}

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.arg});
  final OtpPageArguments arg;
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginError) {
          context.openDialog(
            context: context,
            title: 'Error!',
            content: state.message,
            doneTitle: '',
            doneOnPress: () {},
          );
        }
        if (state is LoginLoading) {
          context.loadingDialog(context: context);
        }
        if (state is VerifyOtpSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.home,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verifying your number'),
          leading: const SizedBox(),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OtpRichText(phoneNumber: widget.arg.phoneNumber),
              OtpTextField(
                controller: otpController,
                onCompleted: (String value) {
                  context.read<LoginCubit>().verifyOtp(
                    otp: value,
                    sessionId: widget.arg.sessionId,
                  );
                },
              ),
              SizedBox(height: 20.h),
              OtpTimer(
                onResendPressed: () {
                  // TODO: Implement resend OTP logic
                  context.read<LoginCubit>().sendOtp(widget.arg.phoneNumber);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

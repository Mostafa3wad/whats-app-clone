import 'package:flutter/material.dart';
import 'package:whats_app_clone/features/login/presentation/widgets/otp_rich_text.dart';
import 'package:whats_app_clone/features/login/presentation/widgets/otp_text_field.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.phoneNumber});
  final String phoneNumber;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
        leading: const SizedBox(),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OtpRichText(phoneNumber: widget.phoneNumber),
            OtpTextField(controller: otpController),
          ],
        ),
      ),
    );
  }
}

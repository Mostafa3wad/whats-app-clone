import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';
import 'package:whats_app_clone/core/constants/paths/route_names.dart';
import 'package:whats_app_clone/core/helpers/validation_helper.dart';
import 'package:whats_app_clone/features/login/presentation/widgets/login_app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  bool _isValidPhoneNumber = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBar(
        title: 'Phone number',
        isValid: _isValidPhoneNumber,
        onTap: () => Navigator.pushNamed(
          context,
          RouteNames.otp,
          arguments: '+20${phoneController.text}',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              child: Text(
                'Please confirm your country code and\nenter your phone number',
                textAlign: TextAlign.center,
                style: AppStyles.b1Blod,
              ),
            ),
            SizedBox(height: 20.h),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Egypt',
                    style: AppStyles.b1Blod.copyWith(
                      color: AppColors.brandColor,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Text('+20', style: AppStyles.b1Blod),
                  const VerticalDivider(),
                  Container(
                    height: 40.h,
                    width: 1,
                    color: Colors.grey.shade400,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        maxLength: 11,
                        autofocus: true,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              _isValidPhoneNumber =
                                  ValidationHelper.isValidEgyptianNumber(
                                        value,
                                      ) !=
                                      null
                                  ? false
                                  : true;
                              log(_isValidPhoneNumber.toString());
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'phone number',
                          border: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(height: 10.h),
            if (phoneController.text.isNotEmpty && !_isValidPhoneNumber)
              Text(
                ValidationHelper.isValidEgyptianNumber(phoneController.text)!,
                style: const TextStyle(color: AppColors.error),
              ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

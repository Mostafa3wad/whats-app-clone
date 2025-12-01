import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/service_locator/service_locator.dart';
import 'package:whats_app_clone/features/chat/presentation/cubit/chat_details_cubit.dart';
import 'package:whats_app_clone/features/chat/presentation/pages/chat_details_page.dart';
import 'package:whats_app_clone/features/home/presentation/pages/home_page.dart';
import 'package:whats_app_clone/features/login/presentation/cubit/login_cubit.dart';
import 'package:whats_app_clone/features/login/presentation/pages/login_page.dart';
import 'package:whats_app_clone/features/login/presentation/pages/otp_page.dart';

import '../../core/constants/paths/route_names.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    // ============ Auth ============
    case RouteNames.login:
      return CupertinoPageRoute<dynamic>(
        builder: (BuildContext context) => BlocProvider(
          create: (context) => sl<LoginCubit>(),
          child: const LoginPage(),
        ),
      );

    case RouteNames.otp:
      final OtpPageArguments arg = settings.arguments as OtpPageArguments;
      return CupertinoPageRoute<dynamic>(
        builder: (BuildContext context) => OtpPage(arg: arg),
      );

    // ============ Home ============
    case RouteNames.home:
      return CupertinoPageRoute<dynamic>(
        builder: (BuildContext context) => const HomePage(),
      );

    // ============ chat ============
    case RouteNames.chatDetails:
      final ChatDetailsArg arg = settings.arguments as ChatDetailsArg;
      return CupertinoPageRoute<dynamic>(
        builder: (BuildContext context) => BlocProvider<ChatDetailsCubit>(
          create: (BuildContext context) => ChatDetailsCubit(
            chatId: arg.chatId,
            contactName: arg.contactName,
          ),
          child: ChatDetailsPage(arg: arg),
        ),
      );

    default:
      return CupertinoPageRoute<dynamic>(
        builder: (_) => const Center(), //TODO: Build route exception page
      );
  }
}

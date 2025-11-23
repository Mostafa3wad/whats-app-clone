import 'package:flutter/cupertino.dart';
import 'package:whats_app_clone/features/login/presentation/pages/login_page.dart';

import '../../core/constants/paths/route_names.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.login:
      return CupertinoPageRoute<dynamic>(
        builder: (BuildContext context) => const LoginPage(),
      );

    default:
      return CupertinoPageRoute<dynamic>(
        builder: (_) => const Center(), //TODO: Build route exception page
      );
  }
}

import 'package:flutter/material.dart';

import '../../core/constants/paths/route_names.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.settings:
    
    default:
      return MaterialPageRoute<dynamic>(
        builder: (_) => const Scaffold(), //TODO: Build route exception page
      );
  }
}

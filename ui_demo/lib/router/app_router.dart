import 'package:flutter/material.dart';

import '../base_components/button_page.dart';
import '../base_components/loading_page.dart';

class RouterName {
  static const String home = '/';
  static const String button = '/button';
  static const String loading = '/loading';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.button:
        return MaterialPageRoute(
          builder: (_) => const ButtonPage(),
          settings: settings,
        );
      case RouterName.loading:
        return MaterialPageRoute(
          builder: (_) => const LoadingPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
          settings: settings,
        );
    }
  }
}

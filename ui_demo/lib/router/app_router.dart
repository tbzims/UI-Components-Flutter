import 'package:flutter/material.dart';

import '../base_components/avatar_page.dart';
import '../base_components/button_page.dart';
import '../base_components/loading_page.dart';
import '../base_components/skeleton_page.dart';
import '../record_list/base_list.dart';
import '../record_list/index_list.dart';
import '../record_list/loading_list.dart';

class RouterName {
  static const String home = '/';
  static const String button = '/button';
  static const String loading = '/loading';
  static const String avatar = '/avatar';
  static const String skeleton = '/skeleton';

  static const String baseList = '/base_list';
  static const String loadingList = '/loading_list';
  static const String indexList = '/index_list';
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
      case RouterName.avatar:
        return MaterialPageRoute(
          builder: (_) => const AvatarPage(),
          settings: settings,
        );
      case RouterName.skeleton:
        return MaterialPageRoute(
          builder: (_) => const SkeletonPage(),
          settings: settings,
        );
      case RouterName.baseList:
        return MaterialPageRoute(
          builder: (_) => const BaseList(),
          settings: settings,
        );
      case RouterName.loadingList:
        return MaterialPageRoute(
          builder: (_) => const LoadingList(),
          settings: settings,
        );
      case RouterName.indexList:
        return MaterialPageRoute(
          builder: (_) => const IndexList(),
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

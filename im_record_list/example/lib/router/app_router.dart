
import 'package:flutter/material.dart';

import '../main.dart';
import '../page/base_list.dart';
import '../page/index_list.dart';
import '../page/loading_list.dart';

class RouterName {
  static const home = '/';
  static const String base = '/base_list';
  static const String loading = '/loading_list';
  static const String index = '/index_list';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.home:
        return MaterialPageRoute(
          builder: (_) =>  MyHomePage(),
          settings: settings,
        );
      case RouterName.base:
        return MaterialPageRoute(
          builder: (_) => const BaseList(),
          settings: settings,
        );
      case RouterName.loading:
        return MaterialPageRoute(
          builder: (_) => const LoadingPage(),
          settings: settings,
        );
        case RouterName.index:
          return MaterialPageRoute(
            builder: (_) => const IndexPage(),
            settings: settings,
          );
      // case RouterName.recordList:
      //   return MaterialPageRoute(
      //     builder: (_) => const RecordPage(),
      //     settings: settings,
      //   );
      // case RouterName.recordListBasic:
      //   return MaterialPageRoute(
      //     builder: (_) => const RecordListBasicPage(),
      //     settings: settings,
      //   );
      // case RouterName.recordListRefresh:
      //   return MaterialPageRoute(
      //     builder: (_) => const RecordListRefreshPage(),
      //     settings: settings,
      //   );
      // case RouterName.recordListIndexed:
      //   return MaterialPageRoute(
      //     builder: (_) => const RecordListIndexedPage(),
      //     settings: settings,
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
          settings: settings,
        );
    }
  }
}

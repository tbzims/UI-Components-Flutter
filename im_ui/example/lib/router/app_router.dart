// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../page/base_components/button_page.dart';
import '../page/base_components/loading_page.dart';
import '../page/base_components/record_item.dart';
import '../page/base_components/record_list/record_list_basic_page.dart';
import '../page/base_components/record_list/record_list_indexed_page.dart';
import '../page/base_components/record_list/record_list_refresh_page.dart';
import '../page/base_components/record_list/record_page.dart';

class RouterName {
  static const String home = '/';
  static const String button = '/button';
  static const String loading = '/loading';
  static const String recordList = '/recordList';
  static const String recordListBasic = '/recordListBasic';
  static const String recordListRefresh = '/recordListRefresh';
  static const String recordListIndexed = '/recordListIndexed';
  static const String recordItem = '/recordItem';
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
      case RouterName.recordList:
        return MaterialPageRoute(
          builder: (_) => const RecordPage(),
          settings: settings,
        );
      case RouterName.recordListBasic:
        return MaterialPageRoute(
          builder: (_) => const RecordListBasicPage(),
          settings: settings,
        );
      case RouterName.recordListRefresh:
        return MaterialPageRoute(
          builder: (_) => const RecordListRefreshPage(),
          settings: settings,
        );
      case RouterName.recordListIndexed:
        return MaterialPageRoute(
          builder: (_) => const RecordListIndexedPage(),
          settings: settings,
        );
      // case RouterName.recordItem:
      //   return MaterialPageRoute(
      //     builder: (_) => const RecordItem(),
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

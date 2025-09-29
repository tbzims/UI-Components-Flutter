// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class DemoLocalizationsJa extends DemoLocalizations {
  DemoLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'IMUI サンプル';

  @override
  String appCount(Object count) {
    return 'アプリ数$count';
  }
}

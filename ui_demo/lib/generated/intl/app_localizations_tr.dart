// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class DemoLocalizationsTr extends DemoLocalizations {
  DemoLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'IMUI Örneği';

  @override
  String appCount(Object count) {
    return 'uygulama sayısı $count';
  }
}

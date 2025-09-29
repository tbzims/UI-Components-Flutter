// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class DemoLocalizationsEn extends DemoLocalizations {
  DemoLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'IMUI DEMO';

  @override
  String appCount(Object count) {
    return 'app count$count';
  }
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SntoImUiLocalizationsEn extends SntoImUiLocalizations {
  SntoImUiLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'IM UI';

  @override
  String appCount(Object count) {
    return 'app count$count';
  }
}

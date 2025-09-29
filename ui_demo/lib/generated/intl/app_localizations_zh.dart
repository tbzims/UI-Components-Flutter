// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class DemoLocalizationsZh extends DemoLocalizations {
  DemoLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'IMUI 示例';

  @override
  String appCount(Object count) {
    return '应用数量是$count';
  }
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class DemoLocalizationsZhTw extends DemoLocalizationsZh {
  DemoLocalizationsZhTw() : super('zh_TW');

  @override
  String get appTitle => 'IMUI 範例';

  @override
  String appCount(Object count) {
    return '應用數量為 $count';
  }
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class ImUiLocalizationsZh extends ImUiLocalizations {
  ImUiLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '即时通讯组件库';

  @override
  String appCount(Object count) {
    return '应用数量是$count';
  }

  @override
  String get language => '语言';

  @override
  String get loading => '加载中...';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class ImUiLocalizationsZhTw extends ImUiLocalizationsZh {
  ImUiLocalizationsZhTw(): super('zh_TW');

  @override
  String get appTitle => '即時通訊元件庫';

  @override
  String appCount(Object count) {
    return '應用數量為 $count';
  }

  @override
  String get language => '語言';

  @override
  String get loading => '載入中...';
}

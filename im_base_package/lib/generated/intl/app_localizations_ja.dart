import 'app_localizations.dart';

/// The translations for Japanese (`ja`).
class ImUiLocalizationsJa extends ImUiLocalizations {
  ImUiLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'インスタントメッセージUI';

  @override
  String appCount(Object count) {
    return 'アプリ数$count';
  }

  @override
  String get language => '言語';

  @override
  String get loading => '読み込み中...';

  @override
  String get pullToRefresh => '引き下げて更新';

  @override
  String get releaseToRefresh => '離して更新';

  @override
  String get refreshing => '更新中...';

  @override
  String get refreshSuccess => '更新成功';

  @override
  String get refreshFailed => '更新失敗';

  @override
  String get pullToLoad => '引き上げてさらに読み込む';

  @override
  String get releaseToLoad => '離してさらに読み込む';

  @override
  String get loadSuccess => '読み込み成功';

  @override
  String get loadFailed => '読み込み失敗';

  @override
  String get noMore => 'データがありません';

  @override
  String get edit => '編集';

  @override
  String get delete => '削除';

  @override
  String get confirm => '確認';

  @override
  String get cancel => 'キャンセル';

  @override
  String get pcLoadOnClick => 'クリックで読み込み';
}

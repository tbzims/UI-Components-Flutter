import 'app_localizations.dart';

/// The translations for English (`en`).
class ImUiLocalizationsEn extends ImUiLocalizations {
  ImUiLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'IM UI';

  @override
  String appCount(Object count) {
    return 'app count$count';
  }

  @override
  String get language => 'Language';

  @override
  String get loading => 'Loading...';

  @override
  String get pullToRefresh => 'Pull to refresh';

  @override
  String get releaseToRefresh => 'Release to refresh';

  @override
  String get refreshing => 'Refreshing...';

  @override
  String get refreshSuccess => 'Refresh success';

  @override
  String get refreshFailed => 'Refresh failed';

  @override
  String get pullToLoad => 'Pull to load more';

  @override
  String get releaseToLoad => 'Release to load more';

  @override
  String get loadSuccess => 'Load success';

  @override
  String get loadFailed => 'Load failed';

  @override
  String get noMore => 'No more data';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get pcLoadOnClick => 'Load on Click';
}

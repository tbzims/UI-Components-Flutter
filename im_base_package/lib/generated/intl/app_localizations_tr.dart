import 'app_localizations.dart';

/// The translations for Turkish (`tr`).
class ImUiLocalizationsTr extends ImUiLocalizations {
  ImUiLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'IM Arayüzü';

  @override
  String appCount(Object count) {
    return 'uygulama sayısı $count';
  }

  @override
  String get language => 'Dil';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get pullToRefresh => 'Yenilemek için çek';

  @override
  String get releaseToRefresh => 'Yenilemek için bırak';

  @override
  String get refreshing => 'Yenileniyor...';

  @override
  String get refreshSuccess => 'Yenileme başarılı';

  @override
  String get refreshFailed => 'Yenileme başarısız';

  @override
  String get pullToLoad => 'Daha fazla yüklemek için çek';

  @override
  String get releaseToLoad => 'Daha fazla yüklemek için bırak';

  @override
  String get loadSuccess => 'Yükleme başarılı';

  @override
  String get loadFailed => 'Yükleme başarısız';

  @override
  String get noMore => 'Daha fazla veri yok';

  @override
  String get edit => 'Düzenle';

  @override
  String get delete => 'Sil';

  @override
  String get confirm => 'Onayla';

  @override
  String get cancel => 'İptal';

  @override
  String get pcLoadOnClick => 'Tıklamayla Yükle';
}

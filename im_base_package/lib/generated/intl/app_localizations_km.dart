import 'app_localizations.dart';

/// The translations for Khmer Central Khmer (`km`).
class ImUiLocalizationsKm extends ImUiLocalizations {
  ImUiLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get appTitle => 'បណ្ណាល័យបង្កើតសមាសធាតុសារជជែក';

  @override
  String appCount(Object count) {
    return 'ចំនួនកម្មវិធីគឺ $count';
  }

  @override
  String get language => 'ភាសា';

  @override
  String get loading => 'កំពុងផ្ទុក...';

  @override
  String get pullToRefresh => 'ទាញ​ចុះ​ដើម្បី​ផ្ទុក​ឡើងវិញ';

  @override
  String get releaseToRefresh => 'លែង​ដើម្បី​ផ្ទុក​ឡើងវិញ';

  @override
  String get refreshing => 'កំពុង​ផ្ទុក​ឡើងវិញ...';

  @override
  String get refreshSuccess => 'ផ្ទុក​ឡើងវិញ​បាន​ជោគជ័យ';

  @override
  String get refreshFailed => 'ផ្ទុក​ឡើងវិញ​បាន​បរាជ័យ';

  @override
  String get pullToLoad => 'ទាញ​ឡើង​ដើម្បី​ផ្ទុក​បន្ថែម';

  @override
  String get releaseToLoad => 'លែង​ដើម្បី​ផ្ទុក​បន្ថែម';

  @override
  String get loadSuccess => 'ផ្ទុក​បាន​ជោគជ័យ';

  @override
  String get loadFailed => 'ផ្ទុក​បាន​បរាជ័យ';

  @override
  String get noMore => 'គ្មាន​ទិន្នន័យ​បន្ថែម​ទៀត​ហើយ';

  @override
  String get edit => 'កែសម្រួល';

  @override
  String get delete => 'លុប';

  @override
  String get confirm => 'យល់ព្រម';

  @override
  String get cancel => 'បោះបង់';

  @override
  String get pcLoadOnClick => 'បង្កើតឡើងនៅពេលចុច';
}

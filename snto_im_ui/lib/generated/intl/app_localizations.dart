import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_km.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of SntoImUiLocalizations
/// returned by `SntoImUiLocalizations.of(context)`.
///
/// Applications need to include `SntoImUiLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'intl/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SntoImUiLocalizations.localizationsDelegates,
///   supportedLocales: SntoImUiLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the SntoImUiLocalizations.supportedLocales
/// property.
abstract class SntoImUiLocalizations {
  SntoImUiLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SntoImUiLocalizations of(BuildContext context) {
    return Localizations.of<SntoImUiLocalizations>(context, SntoImUiLocalizations)!;
  }

  static const LocalizationsDelegate<SntoImUiLocalizations> delegate = _SntoImUiLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('km'),
    Locale('zh'),
    Locale('zh', 'TW')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'IM UI'**
  String get appTitle;

  /// No description provided for @appCount.
  ///
  /// In en, this message translates to:
  /// **'app count{count}'**
  String appCount(Object count);
}

class _SntoImUiLocalizationsDelegate extends LocalizationsDelegate<SntoImUiLocalizations> {
  const _SntoImUiLocalizationsDelegate();

  @override
  Future<SntoImUiLocalizations> load(Locale locale) {
    return SynchronousFuture<SntoImUiLocalizations>(lookupSntoImUiLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'km', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_SntoImUiLocalizationsDelegate old) => false;
}

SntoImUiLocalizations lookupSntoImUiLocalizations(Locale locale) {

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh': {
  switch (locale.countryCode) {
    case 'TW': return SntoImUiLocalizationsZhTw();
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return SntoImUiLocalizationsEn();
    case 'km': return SntoImUiLocalizationsKm();
    case 'zh': return SntoImUiLocalizationsZh();
  }

  throw FlutterError(
    'SntoImUiLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

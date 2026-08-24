import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Nom de l'application affiché dans la barre de titre
  ///
  /// In fr, this message translates to:
  /// **'Cycle App'**
  String get appTitle;

  /// No description provided for @summaryNextPeriodToday.
  ///
  /// In fr, this message translates to:
  /// **'Règles attendues aujourd\'hui'**
  String get summaryNextPeriodToday;

  /// Nombre de jours avant les prochaines règles estimées
  ///
  /// In fr, this message translates to:
  /// **'{days, plural, =1{Règles dans 1 jour} other{Règles dans {days} jours}}'**
  String summaryNextPeriodIn(int days);

  /// Date d'ovulation estimée
  ///
  /// In fr, this message translates to:
  /// **'Ovulation estimée le {date}'**
  String summaryOvulationEstimated(String date);

  /// Plage de la fenêtre de fertilité estimée
  ///
  /// In fr, this message translates to:
  /// **'Fenêtre de fertilité : du {start} au {end}'**
  String summaryFertileWindow(String start, String end);

  /// No description provided for @legendPeriod.
  ///
  /// In fr, this message translates to:
  /// **'Règles'**
  String get legendPeriod;

  /// No description provided for @legendPredictedPeriod.
  ///
  /// In fr, this message translates to:
  /// **'Règles prédites'**
  String get legendPredictedPeriod;

  /// No description provided for @legendFertileWindow.
  ///
  /// In fr, this message translates to:
  /// **'Fenêtre de fertilité'**
  String get legendFertileWindow;

  /// No description provided for @legendOvulation.
  ///
  /// In fr, this message translates to:
  /// **'Ovulation'**
  String get legendOvulation;

  /// No description provided for @addEntryTitle.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter des règles'**
  String get addEntryTitle;

  /// No description provided for @editEntryTitle.
  ///
  /// In fr, this message translates to:
  /// **'Modifier les règles'**
  String get editEntryTitle;

  /// No description provided for @startDateLabel.
  ///
  /// In fr, this message translates to:
  /// **'Date de début'**
  String get startDateLabel;

  /// No description provided for @endDateLabel.
  ///
  /// In fr, this message translates to:
  /// **'Date de fin (optionnel)'**
  String get endDateLabel;

  /// No description provided for @endDateOngoingHint.
  ///
  /// In fr, this message translates to:
  /// **'Toujours en cours'**
  String get endDateOngoingHint;

  /// No description provided for @saveButton.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get saveButton;

  /// No description provided for @cancelButton.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancelButton;

  /// No description provided for @deleteButton.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get deleteButton;

  /// No description provided for @emptyStateTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucune donnée pour l\'instant'**
  String get emptyStateTitle;

  /// No description provided for @emptyStateMessage.
  ///
  /// In fr, this message translates to:
  /// **'Appuie sur une date dans le calendrier pour enregistrer le début de tes prochaines règles.'**
  String get emptyStateMessage;

  /// No description provided for @errorEndBeforeStart.
  ///
  /// In fr, this message translates to:
  /// **'La date de fin doit être après la date de début.'**
  String get errorEndBeforeStart;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

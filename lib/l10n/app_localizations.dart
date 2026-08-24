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

  /// No description provided for @phaseMenstrualName.
  ///
  /// In fr, this message translates to:
  /// **'Règles'**
  String get phaseMenstrualName;

  /// No description provided for @phaseMenstrualDescription.
  ///
  /// In fr, this message translates to:
  /// **'Ton corps élimine la muqueuse utérine. L\'énergie est souvent basse.'**
  String get phaseMenstrualDescription;

  /// No description provided for @phaseMenstrualTag1.
  ///
  /// In fr, this message translates to:
  /// **'Fatigue'**
  String get phaseMenstrualTag1;

  /// No description provided for @phaseMenstrualTag2.
  ///
  /// In fr, this message translates to:
  /// **'Crampes'**
  String get phaseMenstrualTag2;

  /// No description provided for @phaseMenstrualTag3.
  ///
  /// In fr, this message translates to:
  /// **'Envie de ralentir'**
  String get phaseMenstrualTag3;

  /// No description provided for @phaseFollicularName.
  ///
  /// In fr, this message translates to:
  /// **'Folliculaire'**
  String get phaseFollicularName;

  /// No description provided for @phaseFollicularDescription.
  ///
  /// In fr, this message translates to:
  /// **'Les hormones remontent, l\'énergie et la motivation augmentent progressivement.'**
  String get phaseFollicularDescription;

  /// No description provided for @phaseFollicularTag1.
  ///
  /// In fr, this message translates to:
  /// **'Énergie croissante'**
  String get phaseFollicularTag1;

  /// No description provided for @phaseFollicularTag2.
  ///
  /// In fr, this message translates to:
  /// **'Humeur stable'**
  String get phaseFollicularTag2;

  /// No description provided for @phaseFollicularTag3.
  ///
  /// In fr, this message translates to:
  /// **'Créativité'**
  String get phaseFollicularTag3;

  /// No description provided for @phaseOvulatoryName.
  ///
  /// In fr, this message translates to:
  /// **'Ovulatoire'**
  String get phaseOvulatoryName;

  /// No description provided for @phaseOvulatoryDescription.
  ///
  /// In fr, this message translates to:
  /// **'Pic d\'œstrogènes autour de l\'ovulation : souvent le pic d\'énergie et de confiance du cycle.'**
  String get phaseOvulatoryDescription;

  /// No description provided for @phaseOvulatoryTag1.
  ///
  /// In fr, this message translates to:
  /// **'Haute énergie'**
  String get phaseOvulatoryTag1;

  /// No description provided for @phaseOvulatoryTag2.
  ///
  /// In fr, this message translates to:
  /// **'Confiance'**
  String get phaseOvulatoryTag2;

  /// No description provided for @phaseOvulatoryTag3.
  ///
  /// In fr, this message translates to:
  /// **'Libido accrue'**
  String get phaseOvulatoryTag3;

  /// No description provided for @phaseLutealName.
  ///
  /// In fr, this message translates to:
  /// **'Lutéale'**
  String get phaseLutealName;

  /// No description provided for @phaseLutealDescription.
  ///
  /// In fr, this message translates to:
  /// **'La progestérone augmente puis chute : le syndrome prémenstruel peut apparaître en fin de phase.'**
  String get phaseLutealDescription;

  /// No description provided for @phaseLutealTag1.
  ///
  /// In fr, this message translates to:
  /// **'Sautes d\'humeur'**
  String get phaseLutealTag1;

  /// No description provided for @phaseLutealTag2.
  ///
  /// In fr, this message translates to:
  /// **'Ballonnements'**
  String get phaseLutealTag2;

  /// No description provided for @phaseLutealTag3.
  ///
  /// In fr, this message translates to:
  /// **'Besoin de calme'**
  String get phaseLutealTag3;

  /// No description provided for @expectedFeelingsLabel.
  ///
  /// In fr, this message translates to:
  /// **'Ressentis typiques'**
  String get expectedFeelingsLabel;

  /// No description provided for @howDoYouFeelButton.
  ///
  /// In fr, this message translates to:
  /// **'Comment tu te sens aujourd\'hui ?'**
  String get howDoYouFeelButton;

  /// No description provided for @symptomSheetTitle.
  ///
  /// In fr, this message translates to:
  /// **'Comment tu te sens aujourd\'hui ?'**
  String get symptomSheetTitle;

  /// No description provided for @symptomNoteLabel.
  ///
  /// In fr, this message translates to:
  /// **'Note (optionnel)'**
  String get symptomNoteLabel;

  /// No description provided for @symptomCramps.
  ///
  /// In fr, this message translates to:
  /// **'Crampes'**
  String get symptomCramps;

  /// No description provided for @symptomFatigue.
  ///
  /// In fr, this message translates to:
  /// **'Fatigue'**
  String get symptomFatigue;

  /// No description provided for @symptomMoodSwings.
  ///
  /// In fr, this message translates to:
  /// **'Sautes d\'humeur'**
  String get symptomMoodSwings;

  /// No description provided for @symptomHeadache.
  ///
  /// In fr, this message translates to:
  /// **'Maux de tête'**
  String get symptomHeadache;

  /// No description provided for @symptomBloating.
  ///
  /// In fr, this message translates to:
  /// **'Ballonnements'**
  String get symptomBloating;

  /// No description provided for @symptomTenderBreasts.
  ///
  /// In fr, this message translates to:
  /// **'Seins sensibles'**
  String get symptomTenderBreasts;

  /// No description provided for @symptomIncreasedEnergy.
  ///
  /// In fr, this message translates to:
  /// **'Regain d\'énergie'**
  String get symptomIncreasedEnergy;

  /// No description provided for @symptomBackPain.
  ///
  /// In fr, this message translates to:
  /// **'Douleurs dorsales'**
  String get symptomBackPain;

  /// No description provided for @symptomNausea.
  ///
  /// In fr, this message translates to:
  /// **'Nausées'**
  String get symptomNausea;

  /// No description provided for @symptomFoodCravings.
  ///
  /// In fr, this message translates to:
  /// **'Envies alimentaires'**
  String get symptomFoodCravings;

  /// No description provided for @symptomAnxiety.
  ///
  /// In fr, this message translates to:
  /// **'Anxiété'**
  String get symptomAnxiety;

  /// No description provided for @symptomAcne.
  ///
  /// In fr, this message translates to:
  /// **'Acné'**
  String get symptomAcne;

  /// No description provided for @historyOpenTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Historique des cycles'**
  String get historyOpenTooltip;

  /// No description provided for @historyScreenTitle.
  ///
  /// In fr, this message translates to:
  /// **'Historique des cycles'**
  String get historyScreenTitle;

  /// No description provided for @historyCycleLengthLabel.
  ///
  /// In fr, this message translates to:
  /// **'Durée du cycle : {days} jours'**
  String historyCycleLengthLabel(int days);

  /// No description provided for @historyPeriodLengthLabel.
  ///
  /// In fr, this message translates to:
  /// **'Durée des règles : {days} jours'**
  String historyPeriodLengthLabel(int days);

  /// No description provided for @historyOngoingLabel.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get historyOngoingLabel;

  /// No description provided for @historyNoSymptomsLabel.
  ///
  /// In fr, this message translates to:
  /// **'Aucun symptôme noté'**
  String get historyNoSymptomsLabel;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun cycle enregistré'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptyMessage.
  ///
  /// In fr, this message translates to:
  /// **'Ajoute des règles depuis le calendrier pour voir ton historique ici.'**
  String get historyEmptyMessage;

  /// No description provided for @profileOpenTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get profileOpenTooltip;

  /// No description provided for @profileScreenTitle.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get profileScreenTitle;

  /// No description provided for @profileNameLabel.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get profileNameLabel;

  /// No description provided for @profileAgeLabel.
  ///
  /// In fr, this message translates to:
  /// **'Âge'**
  String get profileAgeLabel;

  /// No description provided for @profileWeightLabel.
  ///
  /// In fr, this message translates to:
  /// **'Poids (lb)'**
  String get profileWeightLabel;

  /// No description provided for @profilePartnerPhoneLabel.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de ton/ta partenaire'**
  String get profilePartnerPhoneLabel;

  /// No description provided for @profileSavedMessage.
  ///
  /// In fr, this message translates to:
  /// **'Profil enregistré'**
  String get profileSavedMessage;

  /// No description provided for @notifyPartnerButton.
  ///
  /// In fr, this message translates to:
  /// **'Prévenir mon/ma partenaire'**
  String get notifyPartnerButton;

  /// No description provided for @notifyPartnerMissingNumber.
  ///
  /// In fr, this message translates to:
  /// **'Ajoute d\'abord le numéro de ton/ta partenaire dans ton profil.'**
  String get notifyPartnerMissingNumber;

  /// No description provided for @partnerMessageTemplate.
  ///
  /// In fr, this message translates to:
  /// **'Salut, je suis en phase {phase} aujourd\'hui.'**
  String partnerMessageTemplate(String phase);
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

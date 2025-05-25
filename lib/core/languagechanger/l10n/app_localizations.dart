import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @helloworld.
  ///
  /// In en, this message translates to:
  /// **'Welcome To you !'**
  String get helloworld;

  /// No description provided for @enterYourData.
  ///
  /// In en, this message translates to:
  /// **'please, Enter Your Data !'**
  String get enterYourData;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Username or E-mail'**
  String get email;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get birthDate;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @signUP.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUP;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'I don\'t have an Account'**
  String get dontHaveAccount;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'I have an Account !'**
  String get haveAccount;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign up With Google'**
  String get signInWithGoogle;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'ooh ! forget My password'**
  String get forgetPassword;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'create new account'**
  String get createAccount;

  /// No description provided for @thisFieldEmpty.
  ///
  /// In en, this message translates to:
  /// **'This data is required'**
  String get thisFieldEmpty;

  /// No description provided for @yourEnteredDataInvalid.
  ///
  /// In en, this message translates to:
  /// **'Your data is invaild !!'**
  String get yourEnteredDataInvalid;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'please, Enter your password !'**
  String get enterYourPassword;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password..'**
  String get wrongPassword;

  /// No description provided for @shortPassword.
  ///
  /// In en, this message translates to:
  /// **'The password is very short'**
  String get shortPassword;

  /// No description provided for @nameerror.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get nameerror;

  /// No description provided for @emailerror.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailerror;

  /// No description provided for @emailerror2.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailerror2;

  /// No description provided for @passworderror.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passworderror;

  /// No description provided for @passworderror2.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passworderror2;

  /// No description provided for @passwordnotIdentical.
  ///
  /// In en, this message translates to:
  /// **'The passwords do not match'**
  String get passwordnotIdentical;

  /// No description provided for @pleaseFill.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields correctly.'**
  String get pleaseFill;

  /// No description provided for @signininfo.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email & password correctly to access your data.'**
  String get signininfo;

  /// No description provided for @mediBotdescription.
  ///
  /// In en, this message translates to:
  /// **'Powered by Gemini AI technology, it provides engaging and instant ads for medical conversations. Ask your questions, get insights, and stay in the know about your health 😊.'**
  String get mediBotdescription;

  /// No description provided for @createprofile.
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get createprofile;

  /// No description provided for @createprofileinfo.
  ///
  /// In en, this message translates to:
  /// **'Please enter your data and you can be changed it again from the settings.'**
  String get createprofileinfo;

  /// No description provided for @fullname.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullname;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @dateofbirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateofbirth;

  /// No description provided for @example.
  ///
  /// In en, this message translates to:
  /// **'Examples'**
  String get example;

  /// No description provided for @jobTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Title'**
  String get jobTitle;

  /// No description provided for @portfolio.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get portfolio;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Personal Summary'**
  String get summary;

  /// No description provided for @profilePic.
  ///
  /// In en, this message translates to:
  /// **'Profile Picture'**
  String get profilePic;

  /// No description provided for @examples.
  ///
  /// In en, this message translates to:
  /// **'Examples'**
  String get examples;

  /// No description provided for @partManagement.
  ///
  /// In en, this message translates to:
  /// **'Section Management'**
  String get partManagement;

  /// No description provided for @help2.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help2;

  /// No description provided for @clickCv.
  ///
  /// In en, this message translates to:
  /// **'Preview Resume'**
  String get clickCv;

  /// No description provided for @personalFile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get personalFile;

  /// No description provided for @parts.
  ///
  /// In en, this message translates to:
  /// **'Sections'**
  String get parts;

  /// No description provided for @personalData.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalData;

  /// No description provided for @edu.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get edu;

  /// No description provided for @experiences.
  ///
  /// In en, this message translates to:
  /// **'Experiences'**
  String get experiences;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @abilities.
  ///
  /// In en, this message translates to:
  /// **'Abilities'**
  String get abilities;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @moreParts.
  ///
  /// In en, this message translates to:
  /// **'More Sections'**
  String get moreParts;

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// No description provided for @coverLetter.
  ///
  /// In en, this message translates to:
  /// **'Cover Letter'**
  String get coverLetter;

  /// No description provided for @addMore.
  ///
  /// In en, this message translates to:
  /// **'Add More'**
  String get addMore;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @process.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get process;

  /// No description provided for @pressCamera.
  ///
  /// In en, this message translates to:
  /// **'Press the camera button to capture a photo'**
  String get pressCamera;

  /// No description provided for @cvPress.
  ///
  /// In en, this message translates to:
  /// **'Press to create your resume'**
  String get cvPress;

  /// No description provided for @eduQuali.
  ///
  /// In en, this message translates to:
  /// **'Educational Qualifications'**
  String get eduQuali;

  /// No description provided for @universityName.
  ///
  /// In en, this message translates to:
  /// **'University Name'**
  String get universityName;

  /// No description provided for @specialization.
  ///
  /// In en, this message translates to:
  /// **'Specialization'**
  String get specialization;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'Graduation Date'**
  String get endDate;

  /// No description provided for @profle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profle;

  /// No description provided for @editprofile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editprofile;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @privacysecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacysecurity;

  /// No description provided for @helpsupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpsupport;

  /// No description provided for @moreoptions.
  ///
  /// In en, this message translates to:
  /// **'More Options'**
  String get moreoptions;

  /// No description provided for @useImage.
  ///
  /// In en, this message translates to:
  /// **'Use Image'**
  String get useImage;

  /// No description provided for @retryCatch.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get retryCatch;

  /// No description provided for @jobTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your job title'**
  String get jobTitleHint;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterName;

  /// No description provided for @enterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhone;

  /// No description provided for @enteremail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enteremail;

  /// No description provided for @enterportoflio.
  ///
  /// In en, this message translates to:
  /// **'Enter your personal website'**
  String get enterportoflio;

  /// No description provided for @enterSummary.
  ///
  /// In en, this message translates to:
  /// **'A brief summary about yourself or your achievements'**
  String get enterSummary;

  /// No description provided for @deletephoto.
  ///
  /// In en, this message translates to:
  /// **'Delete Photo'**
  String get deletephoto;

  /// No description provided for @compantName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get compantName;

  /// No description provided for @enterCompany.
  ///
  /// In en, this message translates to:
  /// **'Enter company name'**
  String get enterCompany;

  /// No description provided for @jobNaming.
  ///
  /// In en, this message translates to:
  /// **'Job Title'**
  String get jobNaming;

  /// No description provided for @enterjobNaming.
  ///
  /// In en, this message translates to:
  /// **'Enter job title'**
  String get enterjobNaming;

  /// No description provided for @currentwork.
  ///
  /// In en, this message translates to:
  /// **'I currently work in this position'**
  String get currentwork;

  /// No description provided for @responsiblity.
  ///
  /// In en, this message translates to:
  /// **'Responsibilities'**
  String get responsiblity;

  /// No description provided for @addresponsiblity.
  ///
  /// In en, this message translates to:
  /// **'Add Responsibility'**
  String get addresponsiblity;

  /// No description provided for @addexperience.
  ///
  /// In en, this message translates to:
  /// **'Add Experience'**
  String get addexperience;

  /// No description provided for @addSkill.
  ///
  /// In en, this message translates to:
  /// **'Add Skill'**
  String get addSkill;

  /// No description provided for @personalSkills.
  ///
  /// In en, this message translates to:
  /// **'Personal Skills'**
  String get personalSkills;

  /// No description provided for @skillName.
  ///
  /// In en, this message translates to:
  /// **'Skill Name'**
  String get skillName;

  /// No description provided for @personalAbility.
  ///
  /// In en, this message translates to:
  /// **'Personal Abilities'**
  String get personalAbility;

  /// No description provided for @whatisyourAbility.
  ///
  /// In en, this message translates to:
  /// **'What are your abilities?'**
  String get whatisyourAbility;

  /// No description provided for @addAbility.
  ///
  /// In en, this message translates to:
  /// **'Add Ability'**
  String get addAbility;

  /// No description provided for @languagespart.
  ///
  /// In en, this message translates to:
  /// **'Languages Section'**
  String get languagespart;

  /// No description provided for @addLanguage.
  ///
  /// In en, this message translates to:
  /// **'Add Language'**
  String get addLanguage;

  /// No description provided for @personalprojects.
  ///
  /// In en, this message translates to:
  /// **'Personal Projects'**
  String get personalprojects;

  /// No description provided for @projectName.
  ///
  /// In en, this message translates to:
  /// **'Project Name'**
  String get projectName;

  /// No description provided for @projectDescription.
  ///
  /// In en, this message translates to:
  /// **'Project Description'**
  String get projectDescription;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @signinwithyourAccount.
  ///
  /// In en, this message translates to:
  /// **'Log in to your account'**
  String get signinwithyourAccount;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'account'**
  String get account;

  /// No description provided for @currentmembership.
  ///
  /// In en, this message translates to:
  /// **'Current Membership'**
  String get currentmembership;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @askBeforeuseMobile.
  ///
  /// In en, this message translates to:
  /// **'Ask before using mobile data'**
  String get askBeforeuseMobile;

  /// No description provided for @darkmode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkmode;

  /// No description provided for @langauageDetection.
  ///
  /// In en, this message translates to:
  /// **'Text Recognition Language'**
  String get langauageDetection;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @termsandConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsandConditions;

  /// No description provided for @privacypolicy.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get privacypolicy;

  /// No description provided for @whoAre.
  ///
  /// In en, this message translates to:
  /// **'Who are we?'**
  String get whoAre;

  /// No description provided for @appshare.
  ///
  /// In en, this message translates to:
  /// **'Share the app'**
  String get appshare;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help\nContact us'**
  String get help;

  /// No description provided for @stillStuding.
  ///
  /// In en, this message translates to:
  /// **'Still Studying'**
  String get stillStuding;

  /// No description provided for @notSpecify.
  ///
  /// In en, this message translates to:
  /// **'Not Specified'**
  String get notSpecify;

  /// No description provided for @stillworking.
  ///
  /// In en, this message translates to:
  /// **'I am currently working in this job'**
  String get stillworking;

  /// No description provided for @repoiblity.
  ///
  /// In en, this message translates to:
  /// **'Responsibility'**
  String get repoiblity;

  /// No description provided for @projectEndDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get projectEndDate;

  /// No description provided for @osr.
  ///
  /// In en, this message translates to:
  /// **'Images will be processed here using Optical Character Recognition (OCR)'**
  String get osr;

  /// No description provided for @writeCoverLetter.
  ///
  /// In en, this message translates to:
  /// **'Write your cover letter here ...'**
  String get writeCoverLetter;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @extractedText.
  ///
  /// In en, this message translates to:
  /// **'Extracted Text'**
  String get extractedText;

  /// No description provided for @noOfwords.
  ///
  /// In en, this message translates to:
  /// **'Number of Words'**
  String get noOfwords;

  /// No description provided for @chooseImage.
  ///
  /// In en, this message translates to:
  /// **'Choose Image'**
  String get chooseImage;

  /// No description provided for @analysisImage.
  ///
  /// In en, this message translates to:
  /// **'Analyze Image'**
  String get analysisImage;

  /// No description provided for @chooseFromGallary.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallary;

  /// No description provided for @cameraCap.
  ///
  /// In en, this message translates to:
  /// **'Capture with Camera'**
  String get cameraCap;

  /// No description provided for @saveaspdf.
  ///
  /// In en, this message translates to:
  /// **'Save as PDF'**
  String get saveaspdf;

  /// No description provided for @textCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy Text'**
  String get textCopy;

  /// No description provided for @textCopyDone.
  ///
  /// In en, this message translates to:
  /// **'Text Copied'**
  String get textCopyDone;

  /// No description provided for @terms_header1.
  ///
  /// In en, this message translates to:
  /// **'1. Introduction'**
  String get terms_header1;

  /// No description provided for @terms_body1.
  ///
  /// In en, this message translates to:
  /// **'By using this app, you agree to comply with the terms of use and privacy policies mentioned below.'**
  String get terms_body1;

  /// No description provided for @terms_header2.
  ///
  /// In en, this message translates to:
  /// **'2. Information Collection'**
  String get terms_header2;

  /// No description provided for @terms_body2.
  ///
  /// In en, this message translates to:
  /// **'We may collect some basic data to improve the user experience, such as device type, usage time, and some non-personal information.'**
  String get terms_body2;

  /// No description provided for @terms_header3.
  ///
  /// In en, this message translates to:
  /// **'3. Use of Information'**
  String get terms_header3;

  /// No description provided for @terms_body3.
  ///
  /// In en, this message translates to:
  /// **'We use the information to improve performance, develop new features, and ensure security.'**
  String get terms_body3;

  /// No description provided for @terms_header4.
  ///
  /// In en, this message translates to:
  /// **'4. User Rights'**
  String get terms_header4;

  /// No description provided for @terms_body4.
  ///
  /// In en, this message translates to:
  /// **'You have the right to access or delete your data at any time. For more details, you can contact us via email.'**
  String get terms_body4;

  /// No description provided for @terms_header5.
  ///
  /// In en, this message translates to:
  /// **'5. Modifications'**
  String get terms_header5;

  /// No description provided for @terms_body5.
  ///
  /// In en, this message translates to:
  /// **'We may update these policies from time to time, so please review them periodically.'**
  String get terms_body5;

  /// No description provided for @terms_header6.
  ///
  /// In en, this message translates to:
  /// **'6. Contact Us'**
  String get terms_header6;

  /// No description provided for @terms_body6.
  ///
  /// In en, this message translates to:
  /// **'If you have any inquiries about these policies, please contact us at: support@example.com'**
  String get terms_body6;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @retypepassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get retypepassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @passworderror1.
  ///
  /// In en, this message translates to:
  /// **'Please enter the new password'**
  String get passworderror1;

  /// No description provided for @additionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additionalInfo;

  /// No description provided for @references.
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get references;

  /// No description provided for @interests.
  ///
  /// In en, this message translates to:
  /// **'Interests'**
  String get interests;

  /// No description provided for @achievementsAwards.
  ///
  /// In en, this message translates to:
  /// **'Achievements & Awards'**
  String get achievementsAwards;

  /// No description provided for @hobbies.
  ///
  /// In en, this message translates to:
  /// **'Hobbies'**
  String get hobbies;

  /// No description provided for @signature.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get signature;

  /// No description provided for @publications.
  ///
  /// In en, this message translates to:
  /// **'Publications'**
  String get publications;

  /// No description provided for @technicalSupport.
  ///
  /// In en, this message translates to:
  /// **'Technical Support'**
  String get technicalSupport;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sentTitle.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sentTitle;

  /// No description provided for @sentMessage.
  ///
  /// In en, this message translates to:
  /// **'We will get back to you soon.'**
  String get sentMessage;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @problemType.
  ///
  /// In en, this message translates to:
  /// **'Problem Type'**
  String get problemType;

  /// No description provided for @problemDescription.
  ///
  /// In en, this message translates to:
  /// **'Problem Description'**
  String get problemDescription;

  /// No description provided for @problemSignup.
  ///
  /// In en, this message translates to:
  /// **'Sign‑up Issue'**
  String get problemSignup;

  /// No description provided for @problemDownload.
  ///
  /// In en, this message translates to:
  /// **'Download Issue'**
  String get problemDownload;

  /// No description provided for @suggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion'**
  String get suggestion;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'search ...'**
  String get search;

  /// No description provided for @merge.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get merge;

  /// No description provided for @split.
  ///
  /// In en, this message translates to:
  /// **'Split'**
  String get split;

  /// No description provided for @compress.
  ///
  /// In en, this message translates to:
  /// **'Compress'**
  String get compress;

  /// No description provided for @pdfToWord.
  ///
  /// In en, this message translates to:
  /// **'PDF to Word'**
  String get pdfToWord;

  /// No description provided for @pdfToPowerPoint.
  ///
  /// In en, this message translates to:
  /// **'PDF to PowerPoint'**
  String get pdfToPowerPoint;

  /// No description provided for @pdfToExcel.
  ///
  /// In en, this message translates to:
  /// **'PDF to Excel'**
  String get pdfToExcel;

  /// No description provided for @wordToPdf.
  ///
  /// In en, this message translates to:
  /// **'Word to PDF'**
  String get wordToPdf;

  /// No description provided for @powerPointToPdf.
  ///
  /// In en, this message translates to:
  /// **'PowerPoint to PDF'**
  String get powerPointToPdf;

  /// No description provided for @excelToPdf.
  ///
  /// In en, this message translates to:
  /// **'Excel to PDF'**
  String get excelToPdf;

  /// No description provided for @editPdf.
  ///
  /// In en, this message translates to:
  /// **'Edit PDF'**
  String get editPdf;

  /// No description provided for @pdfToJpg.
  ///
  /// In en, this message translates to:
  /// **'PDF to JPG'**
  String get pdfToJpg;

  /// No description provided for @pdfToImage.
  ///
  /// In en, this message translates to:
  /// **'PDF to Image'**
  String get pdfToImage;

  /// No description provided for @pageNumbering.
  ///
  /// In en, this message translates to:
  /// **'Page Numbering'**
  String get pageNumbering;

  /// No description provided for @watermark.
  ///
  /// In en, this message translates to:
  /// **'Watermark'**
  String get watermark;

  /// No description provided for @rotatePdf.
  ///
  /// In en, this message translates to:
  /// **'Rotate PDF'**
  String get rotatePdf;

  /// No description provided for @unlockPdf.
  ///
  /// In en, this message translates to:
  /// **'Unlock PDF'**
  String get unlockPdf;

  /// No description provided for @protectPdf.
  ///
  /// In en, this message translates to:
  /// **'Protect PDF'**
  String get protectPdf;

  /// No description provided for @organizePdf.
  ///
  /// In en, this message translates to:
  /// **'Organize PDF'**
  String get organizePdf;

  /// No description provided for @repairPdf.
  ///
  /// In en, this message translates to:
  /// **'Repair PDF'**
  String get repairPdf;

  /// No description provided for @signPdf.
  ///
  /// In en, this message translates to:
  /// **'Sign PDF'**
  String get signPdf;

  /// No description provided for @createPdf.
  ///
  /// In en, this message translates to:
  /// **'Create PDF'**
  String get createPdf;

  /// No description provided for @addText.
  ///
  /// In en, this message translates to:
  /// **'Add Text'**
  String get addText;

  /// No description provided for @imageToPdf.
  ///
  /// In en, this message translates to:
  /// **'Image to PDF'**
  String get imageToPdf;

  /// No description provided for @internalStorage.
  ///
  /// In en, this message translates to:
  /// **'Internal Storage'**
  String get internalStorage;

  /// No description provided for @downloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloads;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @files.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get files;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Cannot access files. Please enable permissions from app settings.'**
  String get permissionDenied;

  /// No description provided for @folderNotFound.
  ///
  /// In en, this message translates to:
  /// **'Cannot access the selected folder.'**
  String get folderNotFound;

  /// No description provided for @noFiles.
  ///
  /// In en, this message translates to:
  /// **'No files found in this folder.'**
  String get noFiles;

  /// No description provided for @selectMoreFiles.
  ///
  /// In en, this message translates to:
  /// **'Please select sufficient files'**
  String get selectMoreFiles;

  /// No description provided for @unsupportedTool.
  ///
  /// In en, this message translates to:
  /// **'Unsupported tool'**
  String get unsupportedTool;

  /// No description provided for @pullfiles.
  ///
  /// In en, this message translates to:
  /// **'Drag and drop to reorder pages'**
  String get pullfiles;

  /// No description provided for @splitPdfTitle.
  ///
  /// In en, this message translates to:
  /// **'Split PDF Files'**
  String get splitPdfTitle;

  /// No description provided for @splitByRange.
  ///
  /// In en, this message translates to:
  /// **'Split by Range'**
  String get splitByRange;

  /// No description provided for @addCustomRanges.
  ///
  /// In en, this message translates to:
  /// **'Add custom ranges'**
  String get addCustomRanges;

  /// No description provided for @fixedRange.
  ///
  /// In en, this message translates to:
  /// **'Fixed Range'**
  String get fixedRange;

  /// No description provided for @setFixedInterval.
  ///
  /// In en, this message translates to:
  /// **'Set fixed interval'**
  String get setFixedInterval;

  /// No description provided for @deletePages.
  ///
  /// In en, this message translates to:
  /// **'Delete Pages'**
  String get deletePages;

  /// No description provided for @deleteSpecificPages.
  ///
  /// In en, this message translates to:
  /// **'Delete specific pages or a page range'**
  String get deleteSpecificPages;

  /// No description provided for @extractAllPages.
  ///
  /// In en, this message translates to:
  /// **'Extract All Pages'**
  String get extractAllPages;

  /// No description provided for @extractAllPagesHint.
  ///
  /// In en, this message translates to:
  /// **'Each selected page will be converted into a separate PDF file.'**
  String get extractAllPagesHint;

  /// No description provided for @splitPdfButton.
  ///
  /// In en, this message translates to:
  /// **'Split PDF'**
  String get splitPdfButton;

  /// No description provided for @totalPages.
  ///
  /// In en, this message translates to:
  /// **'Total number of pages'**
  String get totalPages;

  /// No description provided for @range.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get range;

  /// No description provided for @fromPage.
  ///
  /// In en, this message translates to:
  /// **'From page number'**
  String get fromPage;

  /// No description provided for @toPage.
  ///
  /// In en, this message translates to:
  /// **'To page number'**
  String get toPage;

  /// No description provided for @addRange.
  ///
  /// In en, this message translates to:
  /// **'Add range'**
  String get addRange;

  /// No description provided for @profileEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEdit;

  /// No description provided for @rotatePDF.
  ///
  /// In en, this message translates to:
  /// **'Rotate PDF files'**
  String get rotatePDF;

  /// No description provided for @unlockPDF.
  ///
  /// In en, this message translates to:
  /// **'Unlock PDF files'**
  String get unlockPDF;

  /// No description provided for @protectPDF.
  ///
  /// In en, this message translates to:
  /// **'Protect PDF file'**
  String get protectPDF;

  /// No description provided for @organizePDF.
  ///
  /// In en, this message translates to:
  /// **'Organize PDF file'**
  String get organizePDF;

  /// No description provided for @pdfFix.
  ///
  /// In en, this message translates to:
  /// **'Repair PDF document'**
  String get pdfFix;

  /// No description provided for @signPDF.
  ///
  /// In en, this message translates to:
  /// **'Sign PDF document'**
  String get signPDF;

  /// No description provided for @createPDF.
  ///
  /// In en, this message translates to:
  /// **'Create PDF file'**
  String get createPDF;

  /// No description provided for @fix.
  ///
  /// In en, this message translates to:
  /// **'Repair PDF document'**
  String get fix;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorites'**
  String get removeFromFavorites;

  /// No description provided for @addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to Favorites'**
  String get addToFavorites;

  /// No description provided for @openFolder.
  ///
  /// In en, this message translates to:
  /// **'Open Folder'**
  String get openFolder;

  /// No description provided for @openfilelocation.
  ///
  /// In en, this message translates to:
  /// **'Show file Location'**
  String get openfilelocation;

  /// No description provided for @txtExtraction.
  ///
  /// In en, this message translates to:
  /// **'Text Extraction'**
  String get txtExtraction;

  /// No description provided for @topdf.
  ///
  /// In en, this message translates to:
  /// **'Convert to pdf'**
  String get topdf;

  /// No description provided for @emptyPart.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get emptyPart;

  /// No description provided for @privacy_header1.
  ///
  /// In en, this message translates to:
  /// **'Introduction'**
  String get privacy_header1;

  /// No description provided for @privacy_body1.
  ///
  /// In en, this message translates to:
  /// **'We are committed to protecting your privacy. This Privacy Policy explains how we collect, use, and safeguard your information when you use our application.'**
  String get privacy_body1;

  /// No description provided for @privacy_header2.
  ///
  /// In en, this message translates to:
  /// **'Information We Collect'**
  String get privacy_header2;

  /// No description provided for @privacy_body2.
  ///
  /// In en, this message translates to:
  /// **'We may collect personal information such as your name, email address, and device information when you interact with our app.'**
  String get privacy_body2;

  /// No description provided for @privacy_header3.
  ///
  /// In en, this message translates to:
  /// **'How We Use Your Information'**
  String get privacy_header3;

  /// No description provided for @privacy_body3.
  ///
  /// In en, this message translates to:
  /// **'We use the collected information to provide and improve our services, send you notifications, and ensure the security of the app.'**
  String get privacy_body3;

  /// No description provided for @privacy_header4.
  ///
  /// In en, this message translates to:
  /// **'Sharing Your Information'**
  String get privacy_header4;

  /// No description provided for @privacy_body4.
  ///
  /// In en, this message translates to:
  /// **'We do not sell or share your personal information with third parties, except as required by law or to protect our rights.'**
  String get privacy_body4;

  /// No description provided for @privacy_header5.
  ///
  /// In en, this message translates to:
  /// **'Your Rights'**
  String get privacy_header5;

  /// No description provided for @privacy_body5.
  ///
  /// In en, this message translates to:
  /// **'You have the right to access, update, or delete your personal information. Please contact us if you have any questions about your data.'**
  String get privacy_body5;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome To you !`
  String get helloworld {
    return Intl.message(
      'Welcome To you !',
      name: 'helloworld',
      desc: '',
      args: [],
    );
  }

  /// `please, Enter Your Data !`
  String get enterYourData {
    return Intl.message(
      'please, Enter Your Data !',
      name: 'enterYourData',
      desc: '',
      args: [],
    );
  }

  /// `Username or E-mail`
  String get email {
    return Intl.message(
      'Username or E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Birthdate`
  String get birthDate {
    return Intl.message(
      'Birthdate',
      name: 'birthDate',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUP {
    return Intl.message(
      'Sign up',
      name: 'signUP',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signininfo {
    return Intl.message(
      'Please enter your email & password correctly to access your data.',
      name: 'Please enter your email & password correctly to access your data.',
      desc: '',
      args: [],
    );
  }

  /// `I don't have an Account`
  String get dontHaveAccount {
    return Intl.message(
      'I don\'t have an Account',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `I have an Account !`
  String get haveAccount {
    return Intl.message(
      'I have an Account !',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up With Google`
  String get signInWithGoogle {
    return Intl.message(
      'Sign up With Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `ooh ! forget My password`
  String get forgetPassword {
    return Intl.message(
      'ooh ! forget My password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `create new account`
  String get createAccount {
    return Intl.message(
      'create new account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `This data is required`
  String get thisFieldEmpty {
    return Intl.message(
      'This data is required',
      name: 'thisFieldEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Your data is invaild !!`
  String get yourEnteredDataInvalid {
    return Intl.message(
      'Your data is invaild !!',
      name: 'yourEnteredDataInvalid',
      desc: '',
      args: [],
    );
  }

  /// `please, Enter your password !`
  String get enterYourPassword {
    return Intl.message(
      'please, Enter your password !',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password..`
  String get wrongPassword {
    return Intl.message(
      'Wrong password..',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `The password is very short`
  String get shortPassword {
    return Intl.message(
      'The password is very short',
      name: 'shortPassword',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

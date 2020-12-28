import 'package:flutter/material.dart';
import 'package:homeapp/l10n/messages_all.dart';
import 'package:intl/intl.dart';

class AppLocalization {
  
  static Future<AppLocalization> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }
  
  // list of locales
  String get heyWorld {
    return Intl.message(
      'heyWorld',
    );
  }
  String get shoppingList {
    return Intl.message(
      'shoppingList'
    );
  }
  String get dashboard {
    return Intl.message(
      'dashboard'
    );
  }
  String get events {
    return Intl.message(
      'events'
    );
  }
  String get todoList {
    return Intl.message(
      'todoList'
    );
  }
  String get logout {
    return Intl.message(
      'logout'
    );
  }
  String get logoutConf {
    return Intl.message(
      'logoutConf'
    );
  }
  String get no {
    return Intl.message(
      'no'
    );
  }
  String get welcomeHome {
    return Intl.message(
      'welcomeHome'
    );
  }
  String get nameTheTask {
    return Intl.message(
      'nameTheTask'
    );
  }
  String get submit {
    return Intl.message(
      'submit'
    );
  }
  String get created {
    return Intl.message(
      'created'
    );
  }
  String get month {
    return Intl.message(
      'month'
    );
  }
  String get twoweeks {
    return Intl.message(
      'twoweeks'
    );
  }
  String get newEvent {
    return Intl.message(
      'newEvent'
    );
  }
  String get eventTitle {
    return Intl.message(
      'eventTitle'
    );
  }
  String get save {
    return Intl.message(
      'save'
    );
  }
  String get addAMessage {
    return Intl.message(
      'addAMessage'
    );
  }
  String get signIn {
    return Intl.message(
      'signIn'
    );
  }
  String get username {
    return Intl.message(
      'username'
    );
  }
  String get password {
    return Intl.message(
      'password'
    );
  }
  String get login {
    return Intl.message(
      'login'
    );
  }
  String get register {
    return Intl.message(
      'register'
    );
  }
  String get passwordAgain {
    return Intl.message(
      'passwordAgain'
    );
  }
  String get invalidUsername {
    return Intl.message(
      'invalidUsername'
    );
  }
  String get invalidPassword {
    return Intl.message(
      'invalidPassword'
    );
  }
  String get serverNotResponding {
    return Intl.message(
      'serverNotResponding'
    );
  }
  String get passwordMustMatch {
    return Intl.message(
      'passwordMustMatch'
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization>{
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['en', 'hu'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false; 
}
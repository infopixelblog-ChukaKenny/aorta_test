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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Stay on the loop by following your favourite leagues.`
  String get stayOnTheLoopByFollowingYourFavouriteLeagues {
    return Intl.message(
      'Stay on the loop by following your favourite leagues.',
      name: 'stayOnTheLoopByFollowingYourFavouriteLeagues',
      desc: '',
      args: [],
    );
  }

  /// `Get latest updates, statistics and events from your favourite team.`
  String get favourite_team_desc {
    return Intl.message(
      'Get latest updates, statistics and events from your favourite team.',
      name: 'favourite_team_desc',
      desc: '',
      args: [],
    );
  }

  /// `Checkscores`
  String get title {
    return Intl.message('Checkscores', name: 'title', desc: '', args: []);
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message('Get Started', name: 'get_started', desc: '', args: []);
  }

  /// `continue`
  String get continuee {
    return Intl.message('continue', name: 'continuee', desc: '', args: []);
  }

  /// `Already have an account? Login`
  String get already_have_an_account_login {
    return Intl.message(
      'Already have an account? Login',
      name: 'already_have_an_account_login',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `leagues`
  String get leagues {
    return Intl.message('leagues', name: 'leagues', desc: '', args: []);
  }

  /// `Search leagues`
  String get search_leagues {
    return Intl.message(
      'Search leagues',
      name: 'search_leagues',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Favorite Leagues`
  String get choose_your_favorite_league {
    return Intl.message(
      'Choose Your Favorite Leagues',
      name: 'choose_your_favorite_league',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Favorite Teams`
  String get choose_your_favorite_teams {
    return Intl.message(
      'Choose Your Favorite Teams',
      name: 'choose_your_favorite_teams',
      desc: '',
      args: [],
    );
  }

  /// `Suggested for you`
  String get suggestedForYou {
    return Intl.message(
      'Suggested for you',
      name: 'suggestedForYou',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message('Favorite', name: 'favorite', desc: '', args: []);
  }

  /// `No {p1} available at the moment, refresh or try again later`
  String empty_template(Object p1) {
    return Intl.message(
      'No $p1 available at the moment, refresh or try again later',
      name: 'empty_template',
      desc: '',
      args: [p1],
    );
  }

  /// `Favourites`
  String get favourites {
    return Intl.message('Favourites', name: 'favourites', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
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

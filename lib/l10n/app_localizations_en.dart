// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get stayOnTheLoopByFollowingYourFavouriteLeagues =>
      'Stay on the loop by following your favourite leagues.';

  @override
  String get favourite_team_desc =>
      'Get latest updates, statistics and events from your favourite team.';

  @override
  String get title => 'Checkscores';

  @override
  String get something_went_wrong => 'Something went wrong';

  @override
  String get get_started => 'Get Started';

  @override
  String get continuee => 'continue';

  @override
  String get already_have_an_account_login => 'Already have an account? Login';

  @override
  String get skip => 'Skip';

  @override
  String get retry => 'Retry';

  @override
  String get leagues => 'leagues';

  @override
  String get search_leagues => 'Search leagues';

  @override
  String get choose_your_favorite_league => 'Choose Your Favorite Leagues';

  @override
  String get choose_your_favorite_teams => 'Choose Your Favorite Teams';

  @override
  String get suggestedForYou => 'Suggested for you';

  @override
  String get favorite => 'Favorite';

  @override
  String empty_template(Object p1) {
    return 'No $p1 available at the moment, refresh or try again later';
  }

  @override
  String get favourites => 'Favourites';

  @override
  String get add => 'Add';
}

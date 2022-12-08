
import 'package:flutter/material.dart';
import 'package:smile_game/ui/auth_page/login_view/login_provider.dart';
import 'package:smile_game/ui/home_page/home_page_view.dart';

abstract class Routes {
  Routes._();


  static String timeAgoSinceDate(DateTime time, {bool numericDates = true}) {
    DateTime notificationDate = time;
    final date2 = DateTime.now();

    final difference = date2.difference(notificationDate);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 min ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static const LOGIN_ROUTE = "login";
  static const HOME_ROUTE = "home";

  static final login = LoginProvider();

  static const home = HomePageView();

  static Route generator(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (context) => login);

      case HOME_ROUTE:
        return MaterialPageRoute(builder: (context) => home);

      default:
        return MaterialPageRoute(builder: (context) => login);
    }
  }
}

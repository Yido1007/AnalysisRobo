import 'package:analysisrobo/screens/client/languages.dart';
import 'package:analysisrobo/screens/client/notifications.dart';
import 'package:analysisrobo/screens/client/themes.dart';
import 'package:analysisrobo/screens/core/loader.dart';
import 'package:go_router/go_router.dart';

import '../screens/home.dart';
import '../screens/client/exchange.dart';
import '../screens/client/profile.dart';
import '../screens/core/eror.dart';

import '../screens/static/about.dart';
import '../screens/static/boarding.dart';
import '../screens/static/help.dart';
import '../screens/static/settings.dart';

// GoRouter configuration
final routes = GoRouter(
  errorBuilder: (context, state) => const ErorScreen(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoaderScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/exchange',
      builder: (context, state) => const ExchangeScreen(),
    ),
    GoRoute(
      path: '/boarding',
      builder: (context, state) => const BoardingScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/help',
      builder: (context, state) => const HelpScreen(),
    ),
    GoRoute(
      path: '/theme',
      builder: (context, state) => const ThemeScreen(),
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/language',
      builder: (context, state) => const LanguageScreen(),
    ),
  ],
);

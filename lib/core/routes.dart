import 'package:analysisrobo/screens/client/languages.dart';
import 'package:analysisrobo/screens/client/news.dart';
import 'package:analysisrobo/screens/client/notifications.dart';
import 'package:analysisrobo/screens/core/themes.dart';
import 'package:analysisrobo/screens/core/loader.dart';
import 'package:analysisrobo/screens/static/home_frame.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/home.dart';
import '../screens/client/exchange.dart';
import '../screens/client/profile.dart';
import '../screens/core/eror.dart';
import '../screens/static/about.dart';
import '../screens/static/boarding.dart';
import '../screens/static/help.dart';
import '../screens/static/settings.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// GoRouter configuration
final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  errorBuilder: (context, state) => const ErorScreen(),
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => HomeScreen(
        state: state,
        child: child,
      ),
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/home',
          pageBuilder: (context, state) => const NoTransitionPage(child: HomeScreenFrame()),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/exchange',
          pageBuilder: (context, state) => const NoTransitionPage(child: ExchangeScreen()),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/settings',
          pageBuilder: (context, state) => const NoTransitionPage(child: SettingsScreen()),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/news',
          pageBuilder: (context, state) => NoTransitionPage(child: NewsScreen()),
        ),
      ],
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const LoaderScreen(),
    ),
    GoRoute(
      path: '/boarding',
      builder: (context, state) => const BoardingScreen(),
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

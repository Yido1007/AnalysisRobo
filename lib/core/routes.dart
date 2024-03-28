import 'package:go_router/go_router.dart';

import '../home.dart';
import '../screens/client/login.dart';
import '../screens/client/profile.dart';
import '../screens/client/register.dart';
import '../screens/core/eror.dart';
import '../screens/core/loader.dart';
import '../screens/static/about.dart';
import '../screens/static/boarding.dart';
import '../screens/static/contact.dart';

// GoRouter configuration
final routes = GoRouter(
  errorBuilder: (context, state) => const ErorScreen(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoaderScreen(),
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
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactScreen(),
    ),
  ],
);

import 'package:go_router/go_router.dart';
import 'package:pmate/features/app/navigation.dart';
import 'package:pmate/features/settings/interface/app_settings/appearance/appearance_settings.dart';
import 'package:pmate/features/settings/interface/feature_settings/task/task_settings.dart';
import 'package:pmate/features/support/interface/subpages/bugs_and_fixes_page.dart';
import 'package:pmate/features/task_management/interface/task_creation_page.dart';
import 'package:pmate/features/settings/interface/settings_page.dart';
import 'package:pmate/features/notifications/interface/notification_page.dart';
import 'package:pmate/features/welcome/interface/welcome_form.dart';
import 'package:pmate/features/welcome/interface/welcome_page.dart';
import 'package:pmate/features/user_authentication/interface/auth_page.dart';
import 'package:pmate/features/user_authentication/interface/login_page.dart';
import 'package:pmate/features/user_authentication/interface/signup_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeFormPage(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthenticationPage(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: 'signup',
          builder: (context, state) => const SignupPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/nav',
      builder: (context, state) => const NavigationCenter(),
      routes: [
        GoRoute(
          path: 'home',
          builder: (context, state) => const NavigationCenter(
            initialPageIndex: 0,
          ),
        ),
        GoRoute(
          path: 'task',
          builder: (context, state) => const NavigationCenter(
            initialPageIndex: 1,
          ),
          routes: [
            GoRoute(
              path: 'create',
              builder: (context, state) => const TaskCreationPage(),
            ),
          ],
        ),
        GoRoute(
          path: 'support',
          builder: (context, state) => const NavigationCenter(
            initialPageIndex: 2,
          ),
          routes: [
            GoRoute(
              path: 'bugsandfixes',
              builder: (context, state) => const BugsAndFixesPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
      routes: [
        GoRoute(
          path: 'appearance',
          builder: (context, state) => const AppearanceSettings(),
        ),
        GoRoute(
          path: 'tasks',
          builder: (context, state) => const TaskSettings(),
        ),
      ],
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationPage(),
    ),
  ],
);

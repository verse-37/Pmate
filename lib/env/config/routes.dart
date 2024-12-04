import 'package:go_router/go_router.dart';
import 'package:pmate/features/app/navigation.dart';
import 'package:pmate/features/home/interface/home_page.dart';
import 'package:pmate/features/settings/interface/app_settings/appearance/appearance_settings.dart';
import 'package:pmate/features/settings/interface/feature_settings/task/task_settings.dart';
import 'package:pmate/features/support/interface/subpages/bugs_and_fixes_page.dart';
import 'package:pmate/features/support/interface/support_page.dart';
import 'package:pmate/features/task_management/interface/task_creation_page.dart';
import 'package:pmate/features/settings/interface/settings_page.dart';
import 'package:pmate/features/notifications/interface/notification_page.dart';
import 'package:pmate/features/task_management/interface/task_page.dart';
import 'package:pmate/features/welcome/interface/welcome_form.dart';
import 'package:pmate/features/welcome/interface/welcome_page.dart';
import 'package:pmate/features/user_authentication/interface/auth_page.dart';
import 'package:pmate/features/user_authentication/interface/login_page.dart';
import 'package:pmate/features/user_authentication/interface/signup_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: WelcomeFormPage.routeName,
      builder: (context, state) => const WelcomeFormPage(),
    ),
    GoRoute(
      path: WelcomePage.routeName,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: AuthenticationPage.routeName,
      builder: (context, state) => const AuthenticationPage(),
      routes: [
        GoRoute(
          path: LoginPage.routeName,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: SignupPage.routeName,
          builder: (context, state) => const SignupPage(),
        ),
      ],
    ),
    GoRoute(
      path: NavigationCenter.routeName,
      builder: (context, state) => const NavigationCenter(),
      routes: [],
    ),
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) => const NavigationCenter(
        initialPageIndex: 0,
      ),
    ),
    GoRoute(
      path: TaskPage.routeName,
      builder: (context, state) => const NavigationCenter(
        initialPageIndex: 1,
      ),
      routes: [
        GoRoute(
          path: TaskCreationPage.routeName,
          builder: (context, state) => const TaskCreationPage(),
        ),
      ],
    ),
    GoRoute(
      path: SupportPage.routeName,
      builder: (context, state) => const NavigationCenter(
        initialPageIndex: 2,
      ),
      routes: [
        GoRoute(
          path: BugsAndFixesPage.routeName,
          builder: (context, state) => const BugsAndFixesPage(),
        ),
      ],
    ),
    GoRoute(
      path: SettingsPage.routeName,
      builder: (context, state) => const SettingsPage(),
      routes: [
        GoRoute(
          path: AppearanceSettings.routeName,
          builder: (context, state) => const AppearanceSettings(),
        ),
        GoRoute(
          path: TaskSettings.routeName,
          builder: (context, state) => const TaskSettings(),
        ),
      ],
    ),
    GoRoute(
      path: NotificationPage.routeName,
      builder: (context, state) => const NotificationPage(),
    ),
  ],
);

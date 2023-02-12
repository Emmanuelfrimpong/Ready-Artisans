import 'package:auto_route/auto_route.dart';

import '../home_page.dart';
import '../login_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
        page: LoginPage, path: '/login', name: 'LoginRoute', initial: true),
    AutoRoute(page: HomePage, path: '/home', name: 'HomeRoute', initial: true),
  ],
)
class $AppRouter {}

//

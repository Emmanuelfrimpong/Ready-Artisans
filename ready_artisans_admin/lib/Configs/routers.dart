import 'package:auto_route/auto_route.dart';
import 'package:ready_artisans_admin/Pages/Home/SubPages/dashboard_page.dart';
import '../Pages/Auth/login_page.dart';
import '../Pages/Home/SubPages/artisans_page.dart';
import '../Pages/Home/SubPages/orders_pages.dart';
import '../Pages/Home/SubPages/settings_page.dart';
import '../Pages/Home/SubPages/users_page.dart';
import '../Pages/Home/home_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: LoginPage,
      path: '/login',
      name: 'LoginRoute',
    ),
    AutoRoute(
        page: HomePage,
        path: '/home',
        name: 'HomeRoute',
        initial: true,
        children: [
          AutoRoute(
              page: DashboardPage,
              path: 'dashboard',
              name: 'DashboardRoute',
              initial: true),
          AutoRoute(page: UsersPage, path: 'users', name: 'UsersRoute'),
          AutoRoute(
              page: SettingsPage, path: 'settings', name: 'SettingsRoute'),
          AutoRoute(
              page: ArtisansPage, path: 'artisans', name: 'ArtisansRoute'),
          AutoRoute(page: OrdersPage, path: 'orders', name: 'OrdersRoute'),
        ]),
  ],
)
class $AppRouter {}

//

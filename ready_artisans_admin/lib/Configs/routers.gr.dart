// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../Pages/Auth/login_page.dart' as _i1;
import '../Pages/Home/home_page.dart' as _i2;
import '../Pages/Home/SubPages/artisans_page.dart' as _i6;
import '../Pages/Home/SubPages/dashboard_page.dart' as _i3;
import '../Pages/Home/SubPages/orders_pages.dart' as _i7;
import '../Pages/Home/SubPages/settings_page.dart' as _i5;
import '../Pages/Home/SubPages/users_page.dart' as _i4;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.DashboardPage(),
      );
    },
    UsersRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.UsersPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.SettingsPage(),
      );
    },
    ArtisansRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.ArtisansPage(),
      );
    },
    OrdersRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.OrdersPage(),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/home',
          fullMatch: true,
        ),
        _i8.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i8.RouteConfig(
          HomeRoute.name,
          path: '/home',
          children: [
            _i8.RouteConfig(
              '#redirect',
              path: '',
              parent: HomeRoute.name,
              redirectTo: 'dashboard',
              fullMatch: true,
            ),
            _i8.RouteConfig(
              DashboardRoute.name,
              path: 'dashboard',
              parent: HomeRoute.name,
            ),
            _i8.RouteConfig(
              UsersRoute.name,
              path: 'users',
              parent: HomeRoute.name,
            ),
            _i8.RouteConfig(
              SettingsRoute.name,
              path: 'settings',
              parent: HomeRoute.name,
            ),
            _i8.RouteConfig(
              ArtisansRoute.name,
              path: 'artisans',
              parent: HomeRoute.name,
            ),
            _i8.RouteConfig(
              OrdersRoute.name,
              path: 'orders',
              parent: HomeRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/home',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.DashboardPage]
class DashboardRoute extends _i8.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i4.UsersPage]
class UsersRoute extends _i8.PageRouteInfo<void> {
  const UsersRoute()
      : super(
          UsersRoute.name,
          path: 'users',
        );

  static const String name = 'UsersRoute';
}

/// generated route for
/// [_i5.SettingsPage]
class SettingsRoute extends _i8.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'settings',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i6.ArtisansPage]
class ArtisansRoute extends _i8.PageRouteInfo<void> {
  const ArtisansRoute()
      : super(
          ArtisansRoute.name,
          path: 'artisans',
        );

  static const String name = 'ArtisansRoute';
}

/// generated route for
/// [_i7.OrdersPage]
class OrdersRoute extends _i8.PageRouteInfo<void> {
  const OrdersRoute()
      : super(
          OrdersRoute.name,
          path: 'orders',
        );

  static const String name = 'OrdersRoute';
}

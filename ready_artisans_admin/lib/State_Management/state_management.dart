import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// ignore: constant_identifier_names
enum Pages { Dashboard, Users, Artisans, Orders, Settings }

final sidebarWithProvider = StateProvider<double>((ref) => 60);
final sideBarOpenProvider = StateProvider<bool>((ref) => false);
final scaffoldKeyProvider =
    Provider<GlobalKey<ScaffoldState>>((ref) => GlobalKey<ScaffoldState>());
final routerKeyProvider =
    Provider<GlobalKey<AutoRouterState>>((ref) => GlobalKey<AutoRouterState>());
final homePageChangeNotifierProvider =
    StateNotifierProvider<HomePageChangeNotifierProvider, Pages>(
        (ref) => HomePageChangeNotifierProvider());

class HomePageChangeNotifierProvider extends StateNotifier<Pages> {
  HomePageChangeNotifierProvider() : super(Pages.Dashboard);

  void changePage(PageRouteInfo page, Pages pageItem,  GlobalKey<AutoRouterState> routerKey,{bool? falsePop}) {
    final router = routerKey.currentState?.controller;
    if (state != pageItem) {
      router?.push(page);
      state = pageItem;
    } else if (falsePop == true) {
      router?.push(page);
      state = pageItem;
    }
  }
}

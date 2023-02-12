import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

enum Pages { Dashboard, Users, Artisans, Orders, Settings }

class StateManagement extends ChangeNotifier {
  double _sideWidth = 60;
  double get sideWidth => _sideWidth;
  void setSideWidth(double width) {
    _sideWidth = width;
    notifyListeners();
  }

  bool isSideBarOpen = false;
  bool get getSideBarOpen => isSideBarOpen;
  void toggleSideBar() {
    isSideBarOpen = !isSideBarOpen;
    _sideWidth = 200;
    notifyListeners();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get getScaffoldKey => scaffoldKey;
  final routerKey = GlobalKey<AutoRouterState>();
  GlobalKey<AutoRouterState> get getRouterKey => routerKey;
  Pages currentPage = Pages.Dashboard;
  Pages get getSelectedPage => currentPage;

  void navigateTo(PageRouteInfo page, Pages pageItem, {bool? falsePop}) {
    final router = getRouterKey.currentState?.controller;
    if (currentPage != pageItem) {
      router?.push(page);
      currentPage = pageItem;
    } else if (falsePop == true) {
      router?.push(page);
      currentPage = pageItem;
    }
    notifyListeners();
  }
}

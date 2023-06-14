import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: constant_identifier_names
enum Pages { Dashboard, Users, Artisans, Orders, Settings }

final sidebarWithProvider = StateProvider<double>((ref) => 60);
final sideBarOpenProvider = StateProvider<bool>((ref) => false);
final scaffoldKeyProvider =
    Provider<GlobalKey<ScaffoldState>>((ref) => GlobalKey<ScaffoldState>());

final homePageItemProvider = StateProvider<Pages>(
  (ref) => Pages.Dashboard,
);

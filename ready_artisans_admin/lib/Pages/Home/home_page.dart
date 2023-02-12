import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ready_artisans_admin/Pages/Home/Components/side_bar.dart';
import 'package:ready_artisans_admin/State_Management/state_management.dart';

import '../../app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateManagement>(builder: (context, navigation, child) {
      return LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          appBar: constraints.maxWidth < 800
              ? AppBar(
                  title: Image.asset(
                    'assets/images/logo_h_t.png',
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications)),
                    const SizedBox(width: 20),
                  ],
                  leading: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    isSelected: false,
                    onPressed: () {
                      if (constraints.maxWidth > 800) {
                        navigation.toggleSideBar();
                      } else {
                        navigation.toggleSideBar();
                        if (navigation
                            .getScaffoldKey.currentState!.isDrawerOpen) {
                          navigation.getScaffoldKey.currentState!.closeDrawer();
                        } else {
                          navigation.getScaffoldKey.currentState!.openDrawer();
                        }
                      }
                    },
                  ),
                  backgroundColor: primaryColor,
                )
              : null,
          body: Scaffold(
            key: navigation.getScaffoldKey,
            drawer: constraints.maxWidth <= 800 ? const SideBard() : null,
            body: constraints.maxWidth > 800
                ? Row(children: [
                    const SideBard(),
                    Expanded(
                        child: AutoRouter(
                      key: navigation.getRouterKey,
                      builder: (context, content) {
                        return content;
                      },
                    ))
                  ])
                : AutoRouter(
                    key: navigation.getRouterKey,
                    builder: (context, content) {
                      return content;
                    },
                  ),
          ),
        );
      });
    });
  }
}

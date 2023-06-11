import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ready_artisans_admin/Pages/Home/Components/side_bar.dart';
import 'package:ready_artisans_admin/State_Management/state_management.dart';
import '../../utils/app_colors.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                        var current= ref.watch(sidebarWithProvider);
                        if (current == 60) {
                          ref.read(sidebarWithProvider.notifier).state = 200;
                        } else {
                          ref.read(sidebarWithProvider.notifier).state = 60;
                        }
                      } else {
                        var current= ref.watch(sidebarWithProvider);
                        if (current == 60) {
                          ref.read(sidebarWithProvider.notifier).state = 200;
                        } else {
                          ref.read(sidebarWithProvider.notifier).state = 60;
                        }
                        var scaffoldKey = ref.watch(scaffoldKeyProvider);
                        if (scaffoldKey.currentState!.isDrawerOpen) {
                          scaffoldKey.currentState!.closeDrawer();
                        } else {
                          scaffoldKey.currentState!.openDrawer();
                        }
                      }
                    },
                  ),
                  backgroundColor: primaryColor,
                )
              : null,
          body: Scaffold(
            key: ref.watch(scaffoldKeyProvider),
            drawer: constraints.maxWidth <= 800 ? const SideBard() : null,
            body: constraints.maxWidth > 800
                ? Row(children: [
                    const SideBard(),
                    Expanded(
                        child: AutoRouter(
                      //key: ref.watch(routerKeyProvider),
                      builder: (context, content) {
                        return content;
                      },
                    ))
                  ])
                : AutoRouter(
                    //key:ref.watch(routerKeyProvider),
                    builder: (context, content) {
                      return content;
                    },
                  ),
          ),
        );
      });

  }
}

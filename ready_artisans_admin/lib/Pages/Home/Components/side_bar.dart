import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ready_artisans_admin/Configs/routers.gr.dart';
import 'package:ready_artisans_admin/State_Management/state_management.dart';
import '../../../utils/app_colors.dart';

class SideBard extends ConsumerStatefulWidget {
  const SideBard({Key? key}) : super(key: key);
  @override
  ConsumerState<SideBard> createState() => _SideBardState();
}

class _SideBardState extends ConsumerState<SideBard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var routerKey = ref.watch(routerKeyProvider);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          width: ref.watch(sidebarWithProvider),
          height: size.height,
          decoration: BoxDecoration(color: secondaryColor, boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3))
          ]),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 5,
                ),
                if (constraints.maxWidth > 800)
                  SideBarItem(
                      onTap: () {
                        var sideWidth = ref.watch(sidebarWithProvider);
                        if (sideWidth == 60) {
                          ref.read(sidebarWithProvider.notifier).state = 200;
                        } else {
                          ref.read(sidebarWithProvider.notifier).state = 60;
                        }
                      },
                      isSelected: false,
                      title: '',
                      icon: Icons.menu),
                const SizedBox(
                  height: 40,
                ),
                SideBarItem(
                    onTap: () {
                      ref
                          .read(homePageChangeNotifierProvider.notifier)
                          .changePage(const DashboardRoute(), Pages.Dashboard,
                              routerKey);
                    },
                    isSelected: ref.watch(homePageChangeNotifierProvider) ==
                        Pages.Dashboard,
                    title: 'Dashboard',
                    icon: Icons.apps),
                SideBarItem(
                    onTap: () {
                      ref
                          .read(homePageChangeNotifierProvider.notifier)
                          .changePage(
                              const UsersRoute(), Pages.Users, routerKey);
                    },
                    isSelected: ref.watch(homePageChangeNotifierProvider) ==
                        Pages.Users,
                    title: 'Users',
                    icon: Icons.people),
                SideBarItem(
                    onTap: () {
                      ref
                          .read(homePageChangeNotifierProvider.notifier)
                          .changePage(
                              const ArtisansRoute(), Pages.Artisans, routerKey);
                    },
                    isSelected: ref.watch(homePageChangeNotifierProvider) ==
                        Pages.Artisans,
                    title: 'Artisans',
                    icon: Icons.work_history),
                SideBarItem(
                    onTap: () {
                      ref
                          .read(homePageChangeNotifierProvider.notifier)
                          .changePage(
                              const OrdersRoute(), Pages.Orders, routerKey);
                    },
                    isSelected: ref.watch(homePageChangeNotifierProvider) ==
                        Pages.Orders,
                    title: 'Request',
                    icon: FontAwesomeIcons.cartShopping),
                SideBarItem(
                    onTap: () {
                      ref
                          .read(homePageChangeNotifierProvider.notifier)
                          .changePage(
                              const SettingsRoute(), Pages.Settings, routerKey);
                    },
                    isSelected: ref.watch(homePageChangeNotifierProvider) ==
                        Pages.Settings,
                    title: 'Settings',
                    icon: FontAwesomeIcons.gears),
                const Divider(
                  color: Colors.white,
                  thickness: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Version 1.0.0',
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}

class SideBarItem extends ConsumerStatefulWidget {
  const SideBarItem(
      {Key? key,
      required this.onTap,
      required this.isSelected,
      required this.title,
      required this.icon})
      : super(key: key);
  final VoidCallback onTap;
  final bool isSelected;
  final String title;
  final IconData icon;
  @override
  ConsumerState<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends ConsumerState<SideBarItem> {
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    var nav = ref.watch(sidebarWithProvider);
      return InkWell(
        onTap: widget.onTap,
        onHover: (value) {
          setState(() {
            onHover = value;
          });
        },
        child: Container(
            height: 65,
            width: nav,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: widget.title.isNotEmpty
                ? widget.isSelected
                    ? background
                    : onHover
                        ? Colors.black.withOpacity(0.3)
                        : Colors.transparent
                : Colors.transparent,
            child: Row(
              mainAxisAlignment: nav == 60
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (widget.title.isEmpty && nav == 200)
                  const Spacer(),
                Icon(
                  widget.icon,
                  color: widget.isSelected ? primaryColor : background,
                ),
                if (nav > 60)
                  const SizedBox(
                    width: 20,
                  ),
                if (nav > 60)
                  Text(
                    widget.title,
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: widget.isSelected ? primaryColor : background),
                  )
              ],
            )),
      );

  }
}

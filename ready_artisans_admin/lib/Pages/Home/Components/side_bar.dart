// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ready_artisans_admin/Configs/routers.gr.dart';
import 'package:ready_artisans_admin/State_Management/state_management.dart';
import '../../../app_colors.dart';

class SideBard extends StatefulWidget {
  const SideBard({Key? key}) : super(key: key);
  @override
  State<SideBard> createState() => _SideBardState();
}

class _SideBardState extends State<SideBard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      return Consumer<StateManagement>(builder: (context, nav, child) {
        return Container(
            width: nav.sideWidth,
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
                          if (nav.sideWidth == 60) {
                            nav.setSideWidth(200);
                          } else {
                            nav.setSideWidth(60);
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
                        nav.navigateTo(const DashboardRoute(), Pages.Dashboard);
                      },
                      isSelected: nav.getSelectedPage == Pages.Dashboard,
                      title: 'Dashboard',
                      icon: Icons.apps),
                  SideBarItem(
                      onTap: () {
                        nav.navigateTo(const UsersRoute(), Pages.Users);
                      },
                      isSelected: nav.getSelectedPage == Pages.Users,
                      title: 'Users',
                      icon: Icons.people),
                  SideBarItem(
                      onTap: () {
                        nav.navigateTo(const ArtisansRoute(), Pages.Artisans);
                      },
                      isSelected: nav.getSelectedPage == Pages.Artisans,
                      title: 'Artisans',
                      icon: Icons.work_history),
                  SideBarItem(
                      onTap: () {
                        nav.navigateTo(const OrdersRoute(), Pages.Orders);
                      },
                      isSelected: nav.getSelectedPage == Pages.Orders,
                      title: 'Request',
                      icon: FontAwesomeIcons.cartShopping),
                  SideBarItem(
                      onTap: () {
                        nav.navigateTo(const SettingsRoute(), Pages.Settings);
                      },
                      isSelected: nav.getSelectedPage == Pages.Settings,
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
    });
  }
}

class SideBarItem extends StatefulWidget {
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
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<StateManagement>(builder: (context, nav, child) {
      return InkWell(
        onTap: widget.onTap,
        onHover: (value) {
          setState(() {
            onHover = value;
          });
        },
        child: Container(
            height: 65,
            width: nav.sideWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: widget.title.isNotEmpty
                ? widget.isSelected
                    ? background
                    : onHover
                        ? Colors.black.withOpacity(0.3)
                        : Colors.transparent
                : Colors.transparent,
            child: Row(
              mainAxisAlignment: nav.sideWidth == 60
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (widget.title.isEmpty && nav.sideWidth == 200)
                  const Spacer(),
                Icon(
                  widget.icon,
                  color: widget.isSelected ? primaryColor : background,
                ),
                if (nav.sideWidth > 60)
                  const SizedBox(
                    width: 20,
                  ),
                if (nav.sideWidth > 60)
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
    });
  }
}

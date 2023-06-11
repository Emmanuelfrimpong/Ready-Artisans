import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/dashboard_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: size.width,
            height: size.width > 800 ? 100 : 30,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(children: [
              if (size.width <= 800)
                Text(
                  'Home/Dashboard',
                  style: GoogleFonts.nunito(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              if (size.width > 800)
                Image.asset(
                  'assets/images/logo_h_t.png',
                ),
              const SizedBox(
                width: 50,
              ),
              const Spacer(),
              if (size.width > 800)
                Text(
                  'Home/Dashboard',
                  style: GoogleFonts.nunito(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                )
            ]),
          ),
          const SizedBox(height: 20),
          const Wrap(
            spacing: 15,
            runAlignment: WrapAlignment.center,
            runSpacing: 15,
            children: [
              DashboardCard(
                color: Colors.blue,
                title: 'Total Users',
                icon: Icons.people,
                figure: '50',
              ),
              DashboardCard(
                color: Colors.green,
                title: 'Total Artisans',
                icon: Icons.work_history,
                figure: '50',
              ),
              DashboardCard(
                color: Colors.red,
                title: 'Total Orders',
                icon: Icons.shopping_cart,
                figure: '50',
              )
            ],
          )
        ]),
      ),
    );
  }
}

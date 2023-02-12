import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
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
                    'Home/Settings',
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
                    'Home/Settings',
                    style: GoogleFonts.nunito(
                        color: Colors.black45, fontWeight: FontWeight.bold),
                  )
              ]),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Services Categories',
                    style: GoogleFonts.poppins(color: Colors.black45),
                  ),
                  Wrap(
                    spacing: 5,
                    children: [
                      Container(
                        width: constraints.maxHeight > 800
                            ? constraints.maxWidth * .8
                            : constraints.maxWidth * .4,
                      )
                    ],
                  ),
                ],
              ),
            )
          ])));
    });
  }
}

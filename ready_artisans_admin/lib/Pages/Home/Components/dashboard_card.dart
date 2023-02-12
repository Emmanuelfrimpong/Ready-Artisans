import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardCard extends StatefulWidget {
  const DashboardCard(
      {super.key, this.title, this.figure, this.color, this.icon, this.onTap});
  final String? title;
  final String? figure;
  final MaterialColor? color;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  List<double>? stops = [0.1, 0.3, 0.7, 0.9];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Container(
        width: constrains.maxWidth <= 600
            ? constrains.maxWidth
            : constrains.maxWidth > 600 && constrains.maxWidth < 900
                ? constrains.maxWidth * .5
                : constrains.maxWidth * .3,
        height: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.1, 0.3, 0.7, 0.9],
              colors: List.generate(4, (index) {
                return Color.lerp(
                    widget.color![100], widget.color![900], index / 9)!;
              })),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              widget.icon,
              color: Colors.black54,
              size: 50,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.figure ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.title ?? '',
                    style: GoogleFonts.nunito(
                        color: Colors.black54,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

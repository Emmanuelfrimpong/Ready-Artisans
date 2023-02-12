import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';
import 'custom_dropdown.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox(
      {Key? key,
      required this.title,
      required this.onTap,
      this.isChecked = false,
      this.startVal,
      this.endVal,
      this.onStartChanged,
      this.alwaysChecked = false,
      this.onEndChanged,
      this.hasTime = false})
      : super(key: key);
  final bool isChecked;
  final String title;
  final VoidCallback onTap;
  final bool hasTime, alwaysChecked;
  final String? startVal, endVal;
  final Function(dynamic)? onStartChanged, onEndChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          isChecked
              ? const Icon(
                  Icons.check_box,
                  color: secondaryColor,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  color: secondaryColor,
                ),
          const SizedBox(width: 10),
          Text(
            title,
            style: GoogleFonts.nunito(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

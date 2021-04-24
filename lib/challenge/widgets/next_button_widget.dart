import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlw5_dev_quiz/core/core.dart';

class NextButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color color;
  final VoidCallback onTap;

  NextButtonWidget({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  NextButtonWidget.green({required String label, required VoidCallback onTap})
      : this.backgroundColor = AppColors.darkGreen,
        this.borderColor = AppColors.darkGreen,
        this.color = AppColors.white,
        this.label = label,
        this.onTap = onTap;

  NextButtonWidget.purple({required String label, required VoidCallback onTap})
      : this.backgroundColor = AppColors.purple,
        this.borderColor = AppColors.purple,
        this.color = AppColors.white,
        this.label = label,
        this.onTap = onTap;

  NextButtonWidget.white({required String label, required VoidCallback onTap})
      : this.backgroundColor = AppColors.white,
        this.borderColor = AppColors.border,
        this.color = AppColors.grey,
        this.label = label,
        this.onTap = onTap;

  NextButtonWidget.transparent({required String label, required VoidCallback onTap})
      : this.backgroundColor = Colors.transparent,
        this.borderColor = Colors.transparent,
        this.color = AppColors.grey,
        this.label = label,
        this.onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
          side: MaterialStateProperty.all(BorderSide(
            color: borderColor,
          )),
        ),
        child: Text(
          label,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: color,
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}

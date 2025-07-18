import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/utils/app_colors.dart';

class DateTimeSeletionTile extends StatelessWidget {
  const DateTimeSeletionTile({super.key, this.ontap, required this.text});
  final VoidCallback? ontap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,

      child: Container(
        height: context.h * 0.07,
        padding: EdgeInsets.all(context.w * 0.02),
        margin: EdgeInsets.only(top: context.h * 0.02),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(fontSize: context.w * 0.033, color: AppColors.grey),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.03,
                vertical: context.h * 0.005,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: context.w * 0.035,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

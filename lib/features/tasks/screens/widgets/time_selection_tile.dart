import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/features/utils/app_str.dart';

class TimeSelectionTile extends StatefulWidget {
  const TimeSelectionTile({super.key, this.ontap, required this.selectedTime});
  final VoidCallback? ontap;
  final DateTime? selectedTime;

  @override
  State<TimeSelectionTile> createState() => _TimeSelectionTileState();
}

class _TimeSelectionTileState extends State<TimeSelectionTile> {
  formatDate(DateTime? selectedTime){
    if(selectedTime!=null){
   return   DateFormat('dd-MM--yy').format(selectedTime);
    } else{
      return"";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
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
           formatDate(widget.selectedTime),
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
                AppStrings.timeString,
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

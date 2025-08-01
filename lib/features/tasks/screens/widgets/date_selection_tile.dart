import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/features/utils/app_str.dart';

class DateSelectionTile extends StatefulWidget {
  const DateSelectionTile({super.key, this.ontap, required this.selectedDate});
  final VoidCallback? ontap;
  final DateTime? selectedDate;

  @override
  State<DateSelectionTile> createState() => _DateSelectionTileState();
}

class _DateSelectionTileState extends State<DateSelectionTile> {
  formatDate(DateTime? selectedDate){
    if(selectedDate!=null){
   return   DateFormat.yMMMEd().format(selectedDate);
    } else{
      return  AppStrings.dateString;
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
              AppStrings.dateString,
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
                  formatDate(widget.selectedDate) ,
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

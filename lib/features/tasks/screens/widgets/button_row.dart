import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/features/utils/app_str.dart';

class ButtonsRowSection extends StatelessWidget {
   ButtonsRowSection({super.key, this.onAdd, this.onDelete});
  final VoidCallback? onAdd;
  final VoidCallback? onDelete;

  //--variables
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.h * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //-- delete button
          MaterialButton(
            elevation: 4,
            height: context.h * 0.06,
            color: Colors.white38,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: AppColors.grey),
            ),
            onPressed: onDelete,
            animationDuration: Duration(seconds: 1),
            child: Row(
              children: [
                Icon(Icons.close, color: AppColors.primaryColor),
                Padding(
                  padding: EdgeInsets.only(left: context.w * 0.02),
                  child: Text(
                    AppStrings.deleteTAsk.toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //-- adding button
          MaterialButton(
            elevation: 8,
            height: context.h * 0.06,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: onAdd,
            animationDuration: Duration(seconds: 1),
            color: AppColors.primaryColor,
            child: Text(
              AppStrings.addTaskString.toUpperCase(),
              style: GoogleFonts.poppins(color: AppColors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

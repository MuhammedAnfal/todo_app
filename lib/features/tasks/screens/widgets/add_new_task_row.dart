import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/utils/app_str.dart';

class AddNewTastRow extends StatelessWidget {
  const AddNewTastRow({super.key, this.isAlreadyExist});
  final bool? isAlreadyExist;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: isAlreadyExist! ? AppStrings.addNewTask : AppStrings.updateCurrentTask,
        style: Theme.of(context).textTheme.displayLarge,
        children: [
          TextSpan(
            text: AppStrings.taskString,
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

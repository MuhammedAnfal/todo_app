import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/features/utils/app_str.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.titleController, this.isDescripton = false, this.onFieldSubmitted, this.onChanged});

  final TextEditingController? titleController;
  final bool isDescripton;

  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.h * 0.015),
      child: ListTile(
        title: TextFormField(

          controller: titleController,
          maxLines: !isDescripton ? 6 : null,
          style: GoogleFonts.poppins(color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(isDescripton ? Icons.bookmark : null, color: AppColors.grey),
            hintText: isDescripton ? AppStrings.addNote : AppStrings.titleOfTextField,
            hintStyle: TextTheme().headlineMedium,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.w * 0.03,
              vertical: context.h * 0.02,
            ),

          ),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

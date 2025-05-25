
import 'package:flutter/material.dart';
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/main.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        
      } ,
      child: Material(
        color: const Color(0xff4568df),
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          height: h * 0.07,
          width: w * 0.15,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.primaryColor),
          child: Icon(Icons.add, color: Colors.white, size: h * 0.027),
        ),
      ),
    );
  }
}

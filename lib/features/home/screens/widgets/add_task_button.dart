import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/tasks/screens/taskview.dart';
import 'package:todo_app/features/utils/app_colors.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoDialogRoute(context: context, builder: (context) => Taskview()),
        );
      },
      child: Material(
        color: const Color(0xff4568df),
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          height: context.h * 0.07,
          width: context.w * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryColor,
          ),
          child: Icon(Icons.add, color: Colors.white, size: context.h * 0.027),
        ),
      ),
    );
  }
}

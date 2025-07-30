import 'package:flutter/material.dart';
import 'package:todo_app/features/extension/size_extension.dart';

class TaskViewAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TaskViewAppBar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(150);
  @override
  State<TaskViewAppBar> createState() => _TaskViewAppBarState();
}

class _TaskViewAppBarState extends State<TaskViewAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,

      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: context.w * 0.025, top: context.h * 0.02),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

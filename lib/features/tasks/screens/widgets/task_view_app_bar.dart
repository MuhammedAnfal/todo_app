import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/main.dart';

class TaskViewAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TaskViewAppBar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(h * 0.1);
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
            padding: EdgeInsets.only(left: w * 0.025, top: h * 0.02),
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

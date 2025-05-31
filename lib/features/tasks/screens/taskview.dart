import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/tasks/screens/widgets/add_new_task_row.dart';
import 'package:todo_app/features/tasks/screens/widgets/task_view_app_bar.dart';
import 'package:todo_app/features/utils/app_str.dart';
import 'package:todo_app/main.dart';

class Taskview extends StatefulWidget {
  const Taskview({super.key});

  @override
  State<Taskview> createState() => _TaskviewState();
}

class _TaskviewState extends State<Taskview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //-- appBar
      appBar: TaskViewAppBar(),

      //-- body
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: h * 0.1,
                child: Row(
                  children: [
                    Expanded(child: Divider(thickness: 2)),

                    //-- text
                    AddNewTastRow(),

                    Expanded(child: Divider(thickness: 2)),
                  ],
                ),
              ),
              //--
              SizedBox(
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-- title of text field
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.03),
                      child: Text(
                        AppStrings.titleOfTextField,
                        style: TextTheme().headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: TextField(
                  maxLines: 6,
                  cursorHeight: 60,
                  style: GoogleFonts.poppins(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: AppStrings.titleOfTextField,
                    hintStyle: TextTheme().headlineSmall,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: w * 0.03,
                      vertical: h * 0.02,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

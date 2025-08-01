import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/models/task.dart';
import 'package:todo_app/features/tasks/screens/taskview.dart';
import 'package:todo_app/features/utils/app_colors.dart';

class TaskWidget extends StatefulWidget {
  const  TaskWidget({super.key, required this.theme, required this.task});

  //-- variables
  final TextTheme theme;
  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  //-- variables
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.task.title;
    subTitleController.text = widget.task.description;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    subTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => Taskview(
                  descriptionController: subTitleController,
                  titleController: titleController,
                ),
          ),
        );
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: context.w * 0.05, vertical: context.h * 0.01),
        decoration: BoxDecoration(
          color: widget.task.isCompleted? const Color.fromARGB(154,119, 144, 229) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 3)),
          ],
        ),
        duration: Duration(milliseconds: 300),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(bottom: context.h * 0.03),
              child: AnimatedContainer(
                width: context.w * 0.2,
                duration: Duration(milliseconds: 600),
                decoration: BoxDecoration(
                  color: widget.task.isCompleted ? AppColors.primaryColor : AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 0.8),
                ),
                child: Icon(Icons.check, color: Colors.white, size: context.h * 0.03),
              ),
            ),
          ),
          //-- task title
          title: Padding(
            padding: EdgeInsets.only(top: context.h * 0.01, bottom: context.h * 0.005),
            child: Text(
              titleController.text.toString(),
              style: GoogleFonts.poppins(
                decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null,
                textStyle: widget.theme.displayMedium,
                fontSize: context.w * 0.04,
                color: widget.task.isCompleted ? AppColors.primaryColor : AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          //-- task description
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subTitleController.text.toString(),
                style: GoogleFonts.poppins(
                  decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null,
                  textStyle: widget.theme.displaySmall,
                  fontSize: context.w * 0.033,
                  color: widget.task.isCompleted ? AppColors.primaryColor : AppColors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),

              //-- dates
              Padding(
                padding: EdgeInsets.only(top: context.h * 0.01, right: context.w * 0.02),
                child: Align(
                  alignment: Alignment.topRight,

                  child: Column(
                    children: [
                      Text(
                        DateFormat('hh : mm a').format(widget.task.createdAtDate),
                        style: GoogleFonts.poppins(
                          textStyle: widget.theme.displaySmall,
                          fontSize: context.w * 0.03,
                          color:widget.task.isCompleted? AppColors.white: Colors.grey,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdTime),
                        style: GoogleFonts.poppins(
                          textStyle: widget.theme.displaySmall,
                          fontSize: context.w * 0.03,
                          color: widget.task.isCompleted? AppColors.white: Colors.grey,
                        ),
                      ),
                    ],
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

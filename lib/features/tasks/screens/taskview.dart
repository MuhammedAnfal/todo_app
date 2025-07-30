import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as DatePicker show showDatePicker;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/tasks/screens/widgets/add_new_task_row.dart';
import 'package:todo_app/features/tasks/screens/widgets/button_row.dart';
import 'package:todo_app/features/tasks/screens/widgets/date_selection_section.dart';
import 'package:todo_app/features/tasks/screens/widgets/task_tile.dart';
import 'package:todo_app/features/tasks/screens/widgets/task_view_app_bar.dart';
import 'package:todo_app/features/tasks/screens/widgets/time_selection_tile.dart';
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/features/utils/app_str.dart';
import 'package:todo_app/main.dart';

import '../../../models/task_model.dart';

class Taskview extends ConsumerStatefulWidget {
  const Taskview({super.key, this.titleController, this.descriptionController});

  final TextEditingController? titleController;
  final TextEditingController? descriptionController;

  @override
  ConsumerState<Taskview> createState() => _TaskviewState();
}

class _TaskviewState extends ConsumerState<Taskview> {
  //-- variables
  final selectedDate = StateProvider<DateTime?>((ref) => null);
  final selectedTime = StateProvider<DateTime?>((ref) => null);

  //-- if any task is there return true or return false
  bool isTaskExist() {
    if (widget.descriptionController?.text == null && widget.titleController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.titleController?.dispose();
    widget.descriptionController?.dispose();
    ref.watch(selectedTime.notifier).state = null;
    ref.watch(selectedDate.notifier).state = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //-- appBar
      appBar: TaskViewAppBar(),

      //-- body
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.w * 0.03),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(child: Divider(thickness: 2)),

                  //-- text
                  AddNewTastRow(),

                  Expanded(child: Divider(thickness: 2)),
                ],
              ),
            ),
            //-- title of the field
            Container(
              margin: EdgeInsets.only(top: context.h * 0.02),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //-- title of text field
                  Padding(
                    padding: EdgeInsets.only(left: context.w * 0.03),
                    child: Text(AppStrings.titleOfTextField, style: TextTheme().headlineMedium),
                  ),
                ],
              ),
            ),

            //-- text field
            TaskTile(titleController: widget.titleController),

            //--descriprtion field
            Padding(
              padding: EdgeInsets.only(top: context.h * 0.015),
              child: TaskTile(titleController: widget.descriptionController, isDescripton: true),
            ),


            //-- date selection tile
            TimeSelectionTile(
              selectedTime: ref.watch(selectedDate),
              ontap: () async {
                var selected = await DatePicker.showDatePicker(
                  lastDate: DateTime(2030, 3, 5),
                  context: context,
                  onDatePickerModeChange: (value) {},
                  firstDate: DateTime.now(),
                );
                if (selected != null) {
                  ref.watch(selectedDate.notifier).state = selected;
                }
              },
            ),
            //-- Date selection tile
            DateSelectionTile(
              ontap: () {
                BottomPicker.time(
                  use24hFormat: true,
                  initialTime: Time(minutes: 59),
                  maxTime: Time(hours: 23),
                  onSubmit: (p0) {
                    ref.watch(selectedTime.notifier).state = p0;
                  },
                  pickerTitle: Text('sss', style: GoogleFonts.poppins(color: AppColors.white, fontWeight: FontWeight.w500)),
                ).show(context);
              },
              selectedDate: ref.watch(selectedTime),
            ),

            //-- Delete and add Buttons
            ButtonsRowSection(
              // selectedDate: DateTime.now(),
              // selectedTime: ref.watch(selectedTime)??DateTime.now(),
              // taskTitle: widget.titleController.toString(),
              // taskDescription: widget.descriptionController.toString(),
              onAdd: () {
                  if (ref.watch(selectedDate) == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please select date')));
                } else if (ref.watch(selectedTime) == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please select time')));
                } else {
                    print(token);
                    print('1');
                  TaskModel task = TaskModel(
                    token: token??'',
                    taskId: '',
                    selectedDate: ref.watch(selectedTime) ?? DateTime.now(),
                    selectedTime: ref.watch(selectedTime) ?? DateTime.now(),
                    taskTitle: widget.titleController.toString(),
                    taskDescription: widget.descriptionController.toString(),
                  );
                  FirebaseFirestore.instance.collection('tasks').add(task.toMap()).then((value) {
                    value.update({
                      'taskId':value.id
                    });
                  },);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

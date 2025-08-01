import 'package:animate_do/animate_do.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as DatePicker show showDatePicker;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/models/task.dart';
import 'package:todo_app/features/tasks/screens/widgets/add_new_task_row.dart';
import 'package:todo_app/features/tasks/screens/widgets/button_row.dart';
import 'package:todo_app/features/tasks/screens/widgets/date_selection_tile.dart';
import 'package:todo_app/features/tasks/screens/widgets/task_tile.dart';
import 'package:todo_app/features/tasks/screens/widgets/task_view_app_bar.dart';
import 'package:todo_app/features/tasks/screens/widgets/time_selection_section.dart';
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/features/utils/app_str.dart';
import 'package:todo_app/features/utils/constants/image_constants.dart/lottie_constants.dart';
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
  final title = StateProvider<String>((ref) => '');
  final description = StateProvider<String>((ref) => '');
  final selectedDate = StateProvider<DateTime?>((ref) => null);
  final selectedTime = StateProvider((ref) => '');

  //-- if any task is there return true or return false
  bool isTaskExist() {
    if (widget.descriptionController?.text == null && widget.titleController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  //-- function for creating or updating tasks
  dynamic isTaskAlreadyExistUpdateOtherWiseCreate() {
    if (widget.titleController?.text != null && widget.descriptionController?.text != null) {
      try {
        //-- updating the current task
        widget.titleController?.text = ref.watch(title);
        widget.descriptionController?.text = ref.watch(description);
      } catch (e) {
        updateWarning(context);
      }
    } else {
      //-- create new task

      if (ref.watch(title) != null && ref.watch(description) != null) {
        var task = Task.create(
          title: ref.watch(title),
          description: ref.watch(description),
          createdTime: DateTime.parse(ref.watch(selectedTime)),
          createdDate: ref.watch(selectedDate),
        );
        //-- we are adding task in to db using inherited widget
        BaseWidget.of(context).dataStore.addTask(task: task);
      } else {
        emptyWarning(context);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    ref.watch(selectedTime.notifier).state = '';
    ref.watch(selectedDate.notifier).state = null;
  }

  @override
  Widget build(BuildContext context) {
   final base = BaseWidget.of(context);
   return ValueListenableBuilder(valueListenable: base.dataStore.listenToTask(), builder: (context, Box<Task> box , child) {
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
                    AddNewTastRow(isAlreadyExist: isTaskExist()),

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
              TaskTile(
                titleController: widget.titleController,
                onFieldSubmitted: (p0) {
                  ref.watch(title.notifier).update((state) => p0);
                },
                onChanged: (p0) {
                  ref.watch(title.notifier).update((state) => p0);
                },
              ),

              //--descriprtion field
              Padding(
                padding: EdgeInsets.only(top: context.h * 0.015),
                child: TaskTile(
                  titleController: widget.descriptionController,
                  isDescripton: true,
                  onFieldSubmitted: (p0) {
                    ref.watch(description.notifier).update((state) => p0);
                  },
                  onChanged: (p0) {
                    ref.watch(description.notifier).update((state) => p0);
                  },
                ),
              ),

              //-- date selection tile
              DateSelectionTile(
                selectedDate: ref.watch(selectedDate),
                ontap: () async {
                  var selected = await DatePicker.showDatePicker(
                    lastDate: DateTime(2030, 3, 5),
                    context: context,
                    onDatePickerModeChange: (value) {},
                    firstDate: DateTime.now(),
                  );
                  if (selected != null) {
                    ref.watch(selectedDate.notifier).state = selected;
                    print(ref.watch(selectedDate));
                  }
                },
              ),
              //-- Date selection tile
              TimeSelectionTile(
                ontap: () {
                  BottomPicker.time(
                    use24hFormat: true,
                    initialTime: Time(minutes: 59),
                    maxTime: Time(hours: 23),
                    onSubmit: (p0) {
                      final DateTime time = p0 as DateTime;
                      final formattedTime = DateFormat('HH : mm').format(time);
                      ref.watch(selectedTime.notifier).state = formattedTime;
                      print(ref.watch(selectedTime).toString());
                    },
                    pickerTitle: Text('sss', style: GoogleFonts.poppins(color: AppColors.white, fontWeight: FontWeight.w500)),
                  ).show(context);
                },
                selectedTime: ref.watch(selectedTime.notifier).state.toString(),
              ),

              //-- Delete and add Buttons
              ButtonsRowSection(
                isAlreadyExist: isTaskExist(),
                onAdd: () {
                  if (ref.watch(selectedDate) == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please select date')));
                  } else if (ref.watch(selectedTime) == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please select time')));
                  } else {
                    print(token);
                    print('1');
                    TaskModel task = TaskModel(
                      token: token ?? '',
                      taskId: '',
                      selectedDate: ref.watch(selectedDate) ?? DateTime.now(),
                      selectedTime: ref.watch(selectedTime) ?? '',
                      taskTitle: widget.titleController.toString(),
                      taskDescription: widget.descriptionController.toString(),
                    );
                    FirebaseFirestore.instance.collection('tasks').add(task.toMap()).then((value) {
                      value.update({'taskId': value.id});
                    });
                  }
                },
              ),
            ],
          ),
        ),
      );


    },);
   }
}

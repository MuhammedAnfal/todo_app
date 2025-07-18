import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/features/utils/app_str.dart';
import 'package:todo_app/main.dart';

class Taskview extends ConsumerStatefulWidget {
  const Taskview({super.key, this.titleController, this.descriptionController});
  final TextEditingController? titleController;
  final TextEditingController? descriptionController;
  @override
  ConsumerState<Taskview> createState() => _TaskviewState();
}

class _TaskviewState extends ConsumerState<Taskview> {
  //-- variables

  //-- if any task is there return true or return false
  bool isTaskExist() {
    if (widget.descriptionController?.text == null && widget.titleController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  final seletedDate = StateProvider((ref) => DateTime.now());

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
                    child: Text(
                      AppStrings.titleOfTextField,
                      style: TextTheme().headlineMedium,
                    ),
                  ),
                ],
              ),
            ),

            //-- text field
            TaskTile(titleController: null),

            //--descriprtion field
            Padding(
              padding: EdgeInsets.only(top: context.h * 0.015),
              child: TaskTile(
                titleController: widget.descriptionController,
                isDescripton: true,
              ),
            ),
            //-- Date selection tile
            DateTimeSeletionTile(
              ontap: () {
                BottomPicker.time(
                  use24hFormat: true,
                  initialTime: Time(minutes: 23),
                  maxTime: Time(hours: 17),

                  pickerTitle: Text(
                    AppStrings.timeString,
                    style: GoogleFonts.poppins(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ).show(context);
              },
              text: AppStrings.timeString,
            ),

            //-- date selection tile
            DateTimeSeletionTile(
              text: AppStrings.timeString,
              ontap: () async {
                var selected = await DatePicker.showDatePicker(
                  lastDate: DateTime(2030, 3, 5),
                  context: context,
                  onDatePickerModeChange: (value) {},
                  firstDate: DateTime.now(),
                );
                if (selected != null) {
                  ref.watch(seletedDate.notifier).update((state) => selected);
                }
              },
            ),

            //-- Delete and add Buttons
            ButtonsRowSection(),
          ],
        ),
      ),
    );
    ;
  }
}

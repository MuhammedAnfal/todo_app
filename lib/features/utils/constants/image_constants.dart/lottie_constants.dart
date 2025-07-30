import 'package:flutter/widgets.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/utils/app_str.dart';

class ImageConstants {
  static const String noTask = 'assets/lottie/no_task.json';
}

//-- empty title or subtitle  textfield warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStrings.oopMessage,
    subMsg: 'You must fill all fields',
    corner: 20,
    duration: 2000,
    padding: EdgeInsets.all(context.w * 0.02),
  );
}

//-- nothing entered  when user try to edit or update current task
dynamic updateWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStrings.oopMessage,
    subMsg: 'You must Edit the task when you try to update it',
    corner: 20,
    duration: 5000,
    padding: EdgeInsets.all(context.w * 0.02),
  );
}

//-- no task warning dialog
noTaskWarningDialog(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppStrings.oopMessage,
    message: "There is no Task for Delete!\n Try to add some task",
    buttonText: "Okay",
    onTapDismiss: () {
      Navigator.of(context).pop();
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

//-- delete all task from db
deleteAllTaskDialog(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppStrings.areYouSure,
    message: "Do you want to delete all tasks? you will not be able to undo this action",
    confirmButtonText: "Okay",
    cancelButtonText: "Cancel",
    onTapCancel: () {
      Navigator.of(context).pop();
    },
    onTapConfirm: () {
      //-- clear all the tasks
      // BaseWidget.of(context).dataStore.box.clear();
      Navigator.of(context).pop();
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

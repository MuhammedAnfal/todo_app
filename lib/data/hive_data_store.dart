import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/features/models/task.dart';

//-- crud using hive

class HiveDataStore {
  //-- box name - String
  static const boxName = 'taskBox';

  //-- our current box with all saved data inside Box<Task>
  final Box<Task> box = Hive.box<Task>(boxName);

  //-- add news task to box
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  //-- show Task
  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  //-- update Task
  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  //-- delete task
  Future<void> deleteTask({required Task task}) async {
    await task.delete();
  }

  //-- listen to box changes
  ValueListenable<Box<Task>> listenToTask() => box.listenable();
}

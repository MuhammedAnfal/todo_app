import 'package:intl/intl.dart';
import 'package:todo_app/features/models/task.dart';

class TaskModel{
  final DateTime selectedTime;
  final DateTime selectedDate;
  final String taskTitle;
  final String taskDescription;
  TaskModel({
    required this.selectedDate,
    required this.selectedTime,
    required this.taskTitle,
    required this.taskDescription,
});
  Map<String,dynamic> toMap(){
    return{
      'selectedDate':selectedDate,
      'selectedTime':selectedTime,
      'taskTitle':taskTitle,
      'taskDescription':taskDescription,
    };
  }
  factory TaskModel.fromMap(Map<String,dynamic>map){
    return TaskModel(
      selectedDate: map['selectedDate']?? DateFormat('dd-MM-yy').format(DateTime.now()),
      selectedTime: map['selectedTime']?? DateFormat('hh:mm').format(DateTime.now()),
      taskTitle: map['taskTitle']??'',
      taskDescription: map['taskDescription']??"",
    );
  }



}
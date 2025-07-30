import 'package:intl/intl.dart';

class TaskModel{
  final DateTime selectedTime;
  final DateTime selectedDate;
  final String taskTitle;
  final String taskDescription;
  final String token;
  final String taskId;
  TaskModel( {
    required this.selectedDate,
    required this.selectedTime,
    required this.taskTitle,
    required this.taskDescription,
    required this.token,
    required this.taskId,
});
  Map<String,dynamic> toMap(){
    return{
      'selectedDate':selectedDate,
      'selectedTime':selectedTime,
      'taskTitle':taskTitle,
      'taskDescription':taskDescription,
      'token':token,
      'taskId':taskId
    };
  }
  factory TaskModel.fromMap(Map<String,dynamic>map){
    return TaskModel(
      selectedDate: map['selectedDate']?? DateFormat('dd-MM-yy').format(DateTime.now()),
      selectedTime: map['selectedTime']?? DateFormat('hh:mm').format(DateTime.now()),
      taskTitle: map['taskTitle']??'',
      taskDescription: map['taskDescription']??"",
      token: map['token']??"",
      taskId: map['taskId']??"",
    );
  }



}
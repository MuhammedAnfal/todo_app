// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:todo_app/features/home/screens/home_view.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  //-- setting type id
  @HiveField(0)
  final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  DateTime createdTime;
  @HiveField(4)
  DateTime createdAtDate;
  @HiveField(5)
  bool isCompleted;

  //-- setting field id
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  //-- create new taks
  factory Task.create({
    required String? id,
    required String? title,
    required String? description,
    required DateTime? createdTime,
    required DateTime? createdAtDate,
    required bool? isCompleted,
  }) => Task(
    id: Uuid().v1(),
    title: title ?? '',
    description: description ?? '',
    createdTime: createdTime ?? DateTime.now(),
    createdAtDate: createdAtDate ?? DateTime.now(),
    isCompleted: isCompleted ?? false,
  );
}

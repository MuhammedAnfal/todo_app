import 'package:animate_do/animate_do.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/extension/space_extension.dart';
import 'package:todo_app/features/home/screens/widgets/add_task_button.dart';
import 'package:todo_app/features/home/screens/widgets/task_widget.dart';
import 'package:todo_app/features/models/task.dart';
import 'package:todo_app/features/utils/app_str.dart';
import 'package:todo_app/features/utils/constants/image_constants.dart/lottie_constants.dart';
import '../../../main.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  //-- variables
  final GlobalKey<SliderDrawerState> sliderKey = GlobalKey<SliderDrawerState>();
  final doneTasks = StateProvider((ref) => 0);

  //-- check how many tasks are done
  int checkDoneTask(List<Task> taskList) {
    Future.delayed(Duration(milliseconds: 500), () {
      for (var a in taskList) {
        if (a.isCompleted) {
          ref.watch(doneTasks.notifier).state++;
        }
      }
    });
    return ref.read(doneTasks);
  }

  @override
  Widget build(BuildContext context) {
    // -- checkValueOfCircleIndicator
    dynamic valueOfCircleIndicator(List<Task> taskList) {
      if (taskList.isEmpty) {
        return 0;
      } else {
        return taskList.length;
      }
    }

    final base = BaseWidget.of(context);
    final theme = Theme.of(context).textTheme;

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTask(),
      builder: (context, Box<Task> box, child) {
        var tasks = box.values.toList();
        tasks.sort((a, b) => b.createdAtDate.compareTo(a.createdAtDate));

        //-- slide drawer
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: AddTaskButton(),
          //-- body
          body: SafeArea(
            child: SizedBox(
              height: context.h,
              width: context.w,
              child: Padding(
                padding: EdgeInsets.only(right: context.w * 0.02, left: context.w * 0.02, bottom: context.w * 0.02),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: context.h * 0.01),
                        child: SizedBox(
                          width: context.w,
                          height: context.h * 0.1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //-- trash icon
                              Padding(
                                padding: EdgeInsets.only(right: context.w * 0.02),
                                child: GestureDetector(
                                  onTap: () async {
                                    base.dataStore.box.isEmpty ? noTaskWarningDialog(context) : deleteAllTaskDialog(context);
                                    // try {
                                    //   final functions = FirebaseFunctions.instance;
                                    //   final result = await functions.httpsCallable('sendNotification').call({
                                    //     'title': 'hi guys',
                                    //     'body': 'this is the notification',
                                    //     'token': token,
                                    //   });
                                    // } catch (e) {
                                    //   noTaskWarningDialog(context);
                                    // }
                                  },
                                  child: Icon(CupertinoIcons.trash, size: context.w * 0.06, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: context.h * 0.05),
                        child: SizedBox(
                          height: context.h * 0.13,
                          width: context.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //-- loader
                              CircularProgressIndicator(
                                value: checkDoneTask(tasks) / valueOfCircleIndicator(tasks),
                                backgroundColor: Colors.grey,
                                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                              ),
                              25.w,
                              //-- top level task
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(AppStrings.mainTitle, style: theme.displayLarge),
                                  3.h,
                                  Text('${checkDoneTask(tasks)} of ${tasks.length} task', style: theme.titleMedium),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      //-- divider
                      Padding(padding: EdgeInsets.only(top: context.h * 0.01), child: Divider(thickness: 2, indent: 60)),

                      //-- task
                      SizedBox(
                        width: context.w,
                        height: context.h * 0.7,
                        child:
                            tasks.isEmpty
                                ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FadeIn(
                                      child: SizedBox(
                                        height: context.h * 0.3,
                                        width: context.w,
                                        child: Lottie.asset(ImageConstants.noTask, animate: tasks.isNotEmpty ? false : true),
                                      ),
                                    ),
                                    FadeInUp(from: 30, child: Text(AppStrings.doneAllTask)),
                                  ],
                                )
                                : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: tasks.length,
                                  itemBuilder: (context, index) {
                                    var task = tasks[index];
                                    //-- swipe to delete task
                                    return Dismissible(
                                      onDismissed: (_) {
                                        base.dataStore.deleteTask(task: task);
                                      },
                                      background: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          //-- icons color
                                          Icon(Icons.delete, color: Colors.grey),

                                          //-- text
                                          Padding(
                                            padding: EdgeInsets.only(left: context.w * 0.010),
                                            child: Text(AppStrings.deletedTask, style: GoogleFonts.poppins(color: Colors.grey)),
                                          ),
                                        ],
                                      ),

                                      //-- swiping direction
                                      direction: DismissDirection.horizontal,
                                      key: Key(task.id.toString()),

                                      //-- tile widget
                                      child: TaskWidget(theme: theme, task: task),
                                    );
                                  },
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

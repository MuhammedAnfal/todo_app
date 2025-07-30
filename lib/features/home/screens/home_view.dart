import 'package:animate_do/animate_do.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final List<int> tasks = [2];
  final GlobalKey<SliderDrawerState> sliderKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Consumer(
      builder: (context, ref, child) {
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
                padding: EdgeInsets.only(
                  right: context.w * 0.02,
                  left: context.w * 0.02,
                  bottom: context.w * 0.02,
                ),
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
                                    print('object');
                                    try {
                                      final functions = FirebaseFunctions.instance;
                                      final result = await functions.httpsCallable('sendNotification').call({
                                        'title': 'hi guys',
                                        'body': 'this is the notification',
                                        'token': token,
                                      });
                                      print(token);

                                      print('Function Response: ${result.data}');
                                    } catch (e) {
                                      print('Function Error: $e');
                                    }
                                    // noTaskWarningDialog(context);
                                  },
                                  child: Icon(
                                    CupertinoIcons.trash,
                                    size: context.w * 0.06,
                                    color: Colors.black,
                                  ),
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
                                value: 1 / 3,
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
                                  Text('1 of 3 task', style: theme.titleMedium),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      //-- divider
                      Padding(
                        padding: EdgeInsets.only(top: context.h * 0.01),
                        child: Divider(thickness: 2, indent: 60),
                      ),

                      //-- tasks
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
                                        child: Lottie.asset(
                                          ImageConstants.noTask,
                                          animate: tasks.isNotEmpty ? false : true,
                                        ),
                                      ),
                                    ),
                                    FadeInUp(from: 30, child: Text(AppStrings.doneAllTask)),
                                  ],
                                )
                                : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: tasks.length,
                                  itemBuilder: (context, index) {
                                    //-- swipe to delete task
                                    return Dismissible(
                                      onDismissed: (_) {
                                        tasks.removeAt(index);
                                        setState(() {});
                                      },
                                      background: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          //-- icons color
                                          Icon(Icons.delete, color: Colors.grey),

                                          //-- text
                                          Padding(
                                            padding: EdgeInsets.only(left: context.w * 0.010),
                                            child: Text(
                                              AppStrings.deletedTask,
                                              style: GoogleFonts.poppins(color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),

                                      //-- swiping direction
                                      direction: DismissDirection.horizontal,
                                      key: Key(index.toString()),

                                      //-- tile widget
                                      child: TaskWidget(
                                        theme: theme,
                                        task: Task(
                                          id: '1',
                                          title: 'Home Task',
                                          description: "cleaning the room",
                                          createdTime: DateTime.now(),
                                          createdAtDate: DateTime.now(),
                                          isCompleted: false,
                                        ),
                                      ),
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

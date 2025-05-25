import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/features/extension/space_extension.dart';
import 'package:todo_app/features/home/screens/home_app_bar.dart';
import 'package:todo_app/features/home/screens/slide_drawer.dart';
import 'package:todo_app/features/home/screens/widgets/add_task_button.dart';
import 'package:todo_app/features/home/screens/widgets/task_widget.dart';
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/features/utils/app_str.dart';
import 'package:todo_app/features/utils/constants/lottie_constants.dart';
import 'package:todo_app/main.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  //-- variables
  final List<int> tasks = [2, 3, 65, 8, 8, 98, 9, 9];
  final GlobalKey<SliderDrawerState> sliderKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Consumer(
      builder: (context, ref, child) {
        return SliderDrawer(
          key: sliderKey,
          isDraggable: false,
          animationDuration: 1000,
          appBar: SizedBox(),
          slider: CustomDrawer(),
          child: Scaffold(
            appBar: HomeAppBar(sliderKey: sliderKey),
            backgroundColor: Colors.white,
            floatingActionButton: AddTaskButton(),

            //-- body
            body: SingleChildScrollView(
              child: SizedBox(
                height: h,
                width: w,
                child: Padding(
                  padding: EdgeInsets.only(right: w * 0.02, left: w * 0.02, bottom: w * 0.02),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.05),
                        child: SizedBox(
                          height: h * 0.13,
                          width: w,
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
                      Padding(padding: EdgeInsets.only(top: h * 0.01), child: Divider(thickness: 2, indent: 60)),

                      //-- tasks
                      SizedBox(
                        width: w,
                        height: h * 0.7,
                        child:
                            tasks.isEmpty
                                ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FadeIn(
                                      child: SizedBox(
                                        height: h * 0.3,
                                        width: w,
                                        child: Lottie.asset(LottieConstants.noTask, animate: tasks.isNotEmpty ? false : true),
                                      ),
                                    ),
                                    FadeInUp(from: 30, child: Text(AppStrings.doneAllTask)),
                                  ],
                                )
                                : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: tasks.length,
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                      onDismissed: (_) {
                                        //-- remove the task from db
                                      },
                                      background: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.delete, color: Colors.grey),
                                          Padding(
                                            padding: EdgeInsets.only(left: w * 0.010),
                                            child: Text(AppStrings.deletedTask, style: GoogleFonts.poppins(color: Colors.grey)),
                                          ),
                                        ],
                                      ),
                                      direction: DismissDirection.horizontal,
                                      key: Key(index.toString()),
                                      child: TaskWidget(theme: theme),
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

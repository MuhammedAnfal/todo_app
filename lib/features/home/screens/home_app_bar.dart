import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/utils/constants/image_constants.dart/lottie_constants.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/main.dart' as context;

class HomeAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const HomeAppBar(this.animationController, {required this.sliderKey, super.key});
  final GlobalKey<SliderDrawerState> sliderKey;
  final AnimationController animationController;
  @override
  ConsumerState<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, 150);
}

class _HomeAppBarState extends ConsumerState<HomeAppBar> with SingleTickerProviderStateMixin {
  // variables
  late AnimationController animationController;
  final isDrawerOpen = StateProvider((ref) => false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  // void ondrawerToggle() {
  //   ref.watch(isDrawerOpen.notifier).state = !ref.watch(isDrawerOpen);
  //   if (ref.watch(isDrawerOpen)) {
  //     widget.sliderKey.currentState?.openSlider();
  //     animationController.forward();
  //   } else {
  //     widget.sliderKey.currentState?.closeSlider();
  //     animationController.reverse();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Padding(
          padding: EdgeInsets.only(top: context.h * 0.01),
          child: SizedBox(
            width: context.w,
            height: context.h * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //== menu icon
                Padding(
                  padding: EdgeInsets.only(left: context.w * 0.02),
                  child: IconButton(
                    onPressed: () {},
                    // onPressed: () => ondrawerToggle(),
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      color: Colors.black,
                      progress: animationController,
                    ),
                  ),
                ),

                //-- trash icon
                Padding(
                  padding: EdgeInsets.only(right: context.w * 0.02),
                  child: GestureDetector(
                    onTap: () {
                      noTaskWarningDialog(context);
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
        );
      },
    );
  }
}

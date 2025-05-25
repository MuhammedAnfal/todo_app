import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todo_app/main.dart';

class HomeAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({required this.sliderKey, super.key});
  final GlobalKey<SliderDrawerState> sliderKey;
  @override
  ConsumerState<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size(w, h * 0.13);
}

class _HomeAppBarState extends ConsumerState<HomeAppBar> with SingleTickerProviderStateMixin {
  // variables
  late AnimationController animationController;
  final isDrawerOpen = StateProvider((ref) => false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void ondrawerToggle() {
    ref.watch(isDrawerOpen.notifier).state = !ref.watch(isDrawerOpen);
    if (ref.watch(isDrawerOpen)) {
      widget.sliderKey.currentState?.openSlider();
      animationController.forward();
    } else {
      widget.sliderKey.currentState?.closeSlider();
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Padding(
          padding: EdgeInsets.only(top: h * 0.01),
          child: SizedBox(
            width: w,
            height: h * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //== menu icon
                Padding(
                  padding: EdgeInsets.only(left: w * 0.02),
                  child: IconButton(
                    onPressed: () => ondrawerToggle(),
                    icon: AnimatedIcon(icon: AnimatedIcons.menu_close, color: Colors.black, progress: animationController),
                  ),
                ),

                //-- trash icon
                Padding(
                  padding: EdgeInsets.only(right: w * 0.02),
                  child: Icon(CupertinoIcons.trash_slash, size: w * 0.06, color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

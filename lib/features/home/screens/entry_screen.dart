import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/home/screens/home_view.dart';
import 'package:todo_app/features/home/screens/slide_drawer.dart';
import 'package:todo_app/features/utils/app_colors.dart';

class EntryScreen extends ConsumerStatefulWidget {
  const EntryScreen({super.key});

  @override
  ConsumerState<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends ConsumerState<EntryScreen>
    with SingleTickerProviderStateMixin {
  //-- variables
  final isMenuOpen = StateProvider((ref) => false);
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..reverse();
    slideAnimation = Tween<Offset>(
      begin: Offset(0.65, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    animationController.forward();
  }

  //-- onpressed on the menu icon
  onPressed() {
    ref.read(isMenuOpen.notifier).update((state) => !ref.read(isMenuOpen));
    animationController.forward();
    if (animationController.status == AnimationStatus.completed) {
      animationController.reverse(); // Reverse if already played
    } else {
      animationController.forward(); // Play forward
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17203A),
      body: Stack(
        children: [
          CustomDrawer(),
          AnimatedBuilder(
            animation: animationController ,
            builder: (context, child) {
              return Transform.translate(
                offset: slideAnimation.value,
                child: Transform(
                  transform:
                      Matrix4.identity()
                        ..setEntry(3, 2, 0.001),

                  child: HomeView(),
                ),
              );
            },
          ),
          //== menu icon
          GestureDetector(
            onTap: () => onPressed(),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1500),
              padding: EdgeInsets.only(
                left: ref.watch(isMenuOpen) ? context.w * 0.45 : 0,
                top: context.h * 0.04,
              ),
              child: Container(
                padding: EdgeInsets.all(context.w * 0.001),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.white,
                ),
                child: AnimatedIcon(
                  icon: AnimatedIcons.close_menu,
                  color: Colors.black,
                  progress: animationController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

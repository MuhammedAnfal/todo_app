import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/extension/size_extension.dart';
import 'package:todo_app/features/models/side_menu_model.dart';

class SideBarMenuItems extends ConsumerStatefulWidget {
  const SideBarMenuItems({
    super.key,
    required this.icon,
    required this.title,
    required this.sideMenuItems,
    required this.index,
    required this.currentIndex,
  });

  final IconData icon;
  final String title;
  final List<SideMenuItemModel> sideMenuItems;
  final int index;
  final currentIndex;

  @override
  ConsumerState<SideBarMenuItems> createState() => _SideBarMenuItemsState();
}

class _SideBarMenuItemsState extends ConsumerState<SideBarMenuItems> {
  //-- variables
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref.watch(widget.currentIndex.notifier).update((state) => widget.index);
        print(ref.watch(widget.currentIndex));
        // = ref.watch(widget.currentIndex) == widget.index;
      },
      child: AnimatedContainer(
        transform: Matrix4.translationValues(
          ref.watch(widget.currentIndex) == widget.index ? -8 : 0,
          0,
          0,
        ),
        transformAlignment: AlignmentGeometry.lerp(
          AlignmentDirectional.topStart,
          Alignment.topRight,
          10,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: context.w * 0.02, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              ref.watch(widget.currentIndex) == widget.index
                  ? Colors.blue
                  : Colors.transparent,
        ),
        child: ListTile(
          leading: Icon(widget.icon, color: Colors.white, size: 30),
          title: Text(
            widget.title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: context.w * 0.037,
            ),
          ),
        ),
      ),
    );
  }
}

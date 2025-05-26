import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/models/side_menu_model.dart';
import 'package:todo_app/main.dart';

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
      child: AnimatedPositioned(
        curve: Curves.fastOutSlowIn,
        width: ref.watch(widget.currentIndex) == widget.index ? w * 0.3 : 0,
        height: 50,

        duration: Duration(milliseconds: 300),
        child: Container(
          margin: EdgeInsets.only(left: w * 0.01, right: w * 0.01),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ref.watch(widget.currentIndex) == widget.index ? Colors.blue : Colors.transparent,
          ),
          child: ListTile(
            leading: Icon(widget.icon, color: Colors.white, size: 30),
            title: Text(
              widget.title,
              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: w * 0.037),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_app/features/home/screens/widgets/side_bar_menu_items.dart';
import 'package:todo_app/features/models/side_menu_model.dart';
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/main.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({super.key});

  @override
  ConsumerState<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  //-- varaibles
  final List<SideMenuItemModel> sideMenuItems = [
    SideMenuItemModel(icon: Iconsax.home_1, title: 'Home'),
    SideMenuItemModel(icon: Iconsax.profile_circle, title: 'Profile'),
    SideMenuItemModel(icon: Iconsax.setting_2, title: 'Settings'),
    SideMenuItemModel(icon: Iconsax.info_circle4, title: 'Details'),
  ];

  final currentIndex = StateProvider((ref) => 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: w,
        decoration: BoxDecoration(color: Color(0xff17203A)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: h * 0.05),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://www.google.com/imgres?q=user%20avatars&imgurl=https%3A%2F%2Fe7.pngegg.com%2Fpngimages%2F78%2F788%2Fpng-clipart-computer-icons-avatar-business-computer-software-user-avatar-child-face-thumbnail.png&imgrefurl=https%3A%2F%2Fwww.pngegg.com%2Fen%2Fsearch%3Fq%3Davatar&docid=vKernhaiNJ00BM&tbnid=UJjULvt-rqvQYM&vet=12ahUKEwjLs_bF9r6NAxWRXGwGHaHJLbY4ChAzegQIFBAA..i&w=348&h=348&hcb=2&ved=2ahUKEwjLs_bF9r6NAxWRXGwGHaHJLbY4ChAzegQIFBAA',
                ),
                radius: 50,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: h * 0.04, bottom: h * 0.01),
              child: Text(
                'Browse',
                style: GoogleFonts.poppins(
                  fontSize: w * 0.037,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
            ),
            Divider(),
            Consumer(
              builder: (context, ref, child) {
                return Container(
                  height: h * 0.3,
                  child: ListView.builder(
                    itemCount: sideMenuItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SideBarMenuItems(
                        index: index,
                        icon: sideMenuItems[index].icon,
                        title: sideMenuItems[index].title,
                        sideMenuItems: sideMenuItems,
                        currentIndex: currentIndex,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

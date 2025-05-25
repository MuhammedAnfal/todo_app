import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/main.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        width: w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryGradientColors[0], AppColors.primaryGradientColors[1]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: h * 0.05 ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://www.google.com/imgres?q=user%20avatars&imgurl=https%3A%2F%2Fe7.pngegg.com%2Fpngimages%2F78%2F788%2Fpng-clipart-computer-icons-avatar-business-computer-software-user-avatar-child-face-thumbnail.png&imgrefurl=https%3A%2F%2Fwww.pngegg.com%2Fen%2Fsearch%3Fq%3Davatar&docid=vKernhaiNJ00BM&tbnid=UJjULvt-rqvQYM&vet=12ahUKEwjLs_bF9r6NAxWRXGwGHaHJLbY4ChAzegQIFBAA..i&w=348&h=348&hcb=2&ved=2ahUKEwjLs_bF9r6NAxWRXGwGHaHJLbY4ChAzegQIFBAA',
                ),
                radius: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

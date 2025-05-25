import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/utils/app_colors.dart';
import 'package:todo_app/main.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.theme});

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 3))],
        ),
        duration: Duration(milliseconds: 300),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(bottom: h * 0.03),
              child: AnimatedContainer(
                width: w * 0.2,
                duration: Duration(milliseconds: 600),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 0.8),
                ),
                child: Icon(Icons.check, color: Colors.white, size: h * 0.03),
              ),
            ),
          ),
          //-- task title
          title: Padding(
            padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.005),
            child: Text(
              'Done',
              style: GoogleFonts.poppins(
                textStyle: theme.displayMedium,
                fontSize: w * 0.04,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          //-- task description
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: GoogleFonts.poppins(
                  textStyle: theme.displaySmall,
                  fontSize: w * 0.033,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
              ),

              //-- dates
              Padding(
                padding: EdgeInsets.only(top: h * 0.01, right: w * 0.02),
                child: Align(
                  alignment: Alignment.topRight,

                  child: Column(
                    children: [
                      Text(
                        'Date',
                        style: GoogleFonts.poppins(textStyle: theme.displaySmall, fontSize: w * 0.03, color: Colors.grey),
                      ),
                      Text(
                        'Sub Date',
                        style: GoogleFonts.poppins(textStyle: theme.displaySmall, fontSize: w * 0.03, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

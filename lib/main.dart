import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home/screens/home_view.dart';

var h;
var w;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
          textTheme: TextTheme(
            displayLarge: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 45),
            titleMedium: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300),
            displayMedium: TextStyle(color: Colors.white, fontSize: 21),
            displaySmall: TextStyle(color: Color.fromARGB(255, 234, 234, 234), fontSize: 14, fontWeight: FontWeight.w400),
            headlineMedium: TextStyle(color: Colors.grey, fontSize: 17),
            headlineSmall: TextStyle(color: Colors.grey, fontSize: 16),
            titleSmall: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        home: HomeView(),
      ),
    );
  }
}

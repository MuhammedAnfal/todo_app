import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/data/hive_data_store.dart';
import 'package:todo_app/features/home/screens/entry_screen.dart';
import 'package:todo_app/features/home/screens/home_view.dart';
import 'package:todo_app/features/home/screens/slide_drawer.dart';
import 'package:todo_app/features/models/task.dart';
import 'package:todo_app/features/models/taskg.dart';
import 'package:todo_app/features/tasks/screens/taskview.dart';

import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // required if using FlutterFire CLI
  );

  await Hive.initFlutter();

  await messa

  //-- register hive adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  //-- open a box
  var box = await Hive.openBox<Task>(HiveDataStore.boxName);

  //-- delete data from previous day
  box.values.forEach((element) {
    if (element.createdTime.day != DateTime.now().day) {
      element.delete();
    } else {
      //-- do nothing
    }
  });
  runApp(BaseWidget(child: const MyApp()));
}

//-- to pass data between widgets while developing app
class BaseWidget extends InheritedWidget {
  BaseWidget({super.key, required super.child});
  final HiveDataStore dataStore = HiveDataStore();

  Widget build(BuildContext context) {
    return const Placeholder();
  }

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Could not find ancestor widget of the base widget type');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            textTheme: TextTheme(
              displayLarge: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 45,
              ),
              titleMedium: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
              displayMedium: TextStyle(color: Colors.white, fontSize: 21),
              displaySmall: TextStyle(
                color: Color.fromARGB(255, 234, 234, 234),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              headlineMedium: TextStyle(color: Colors.grey, fontSize: 17),
              headlineSmall: TextStyle(color: Colors.grey, fontSize: 16),
              titleSmall: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          home: EntryScreen(),
        ),
      ),
    );
  }
}

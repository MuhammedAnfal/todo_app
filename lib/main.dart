import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/data/hive_data_store.dart';
import 'package:todo_app/features/home/screens/entry_screen.dart';
import 'package:todo_app/features/models/task.dart';
import 'package:todo_app/features/models/taskg.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String? token;
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // required if using FlutterFire CLI
  );

  await Hive.initFlutter();

  await NotificationService.instance.initialize();
  FirebaseMessaging message = FirebaseMessaging.instance;

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("🟢 Foreground message: ${message.notification?.title}");

    if (message.notification != null) {
      NotificationService.instance.showNotification(
        message.notification?.title ?? "No title",
        message.notification?.body ?? "No body",
      );
    }
  });

  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

  //-- create a background handler
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

    print("🔵 Background message: ${message.notification?.title}");

    // Optional: show local notification
    NotificationService.instance.showNotification(
      message.notification?.title ?? "No title",
      message.notification?.body ?? "No body",
    );
  }
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
  //   final String? payload = notificationResponse.payload;
  //   if (notificationResponse.payload != null) {
  //     debugPrint('notification payload: $payload');
  //   }
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  //   );
  // }

  //-- request for permission ( in ios required)
  await message.requestPermission();
   token = await message.getToken();



  //-- register hive adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  //-- open a box
  var box = await Hive.openBox<Task>(HiveDataStore.boxName);

  //-- delete data from previous day
  for (var element in box.values) {
    if (element.createdTime.day != DateTime.now().day) {
      element.delete();
    } else {
      //-- do nothing
    }
  }
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

class NotificationService {
  static final NotificationService instance = NotificationService._();
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  NotificationService._();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iOSSettings =
    DarwinInitializationSettings();

    final InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _plugin.initialize(initSettings);
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _plugin.show(0, title, body, notificationDetails);
  }
}

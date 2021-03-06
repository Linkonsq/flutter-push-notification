import 'package:app_settings/app_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:push_notifications/green_page.dart';
import 'package:push_notifications/red_page.dart';
import 'package:push_notifications/services/local_notification_service.dart';

/// App in background
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Push Notifications'),
      routes: {
        "red": (_) => const RedPage(),
        "green": (_) => const GreenPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize(context);

    /// wake app on tap notification from close state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      final routeFromMessage = message!.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });

    /// Foreground
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(message);
    });

    /// When the app is in background but opened
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  void requestPermission(BuildContext context) async {
    if (await Permission.notification.request().isGranted) {
      //print("Got access to notification");
    } else if (await Permission.notification.status.isDenied) {
      await Permission.notification.request();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Please turn on notification"),
        action: SnackBarAction(
          label: "Open Setting",
          onPressed: () => AppSettings.openNotificationSettings(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    requestPermission(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: Text(
            'You will receive push notifications',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

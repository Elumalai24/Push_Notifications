import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("fbToken:${fcmToken}");
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification!.title}');
    }
  });
  runApp( MaterialApp(home: Notification(),));
}

class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);
  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    print("build called");
    return Scaffold(appBar: AppBar(title: Text("Firebase Notifcation"),),);
  }
}

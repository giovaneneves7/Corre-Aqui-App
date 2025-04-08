import 'package:corre_aqui/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:corre_aqui/features/auth/screens/auth_gate.dart';
import 'package:corre_aqui/theme/custom_theme.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'helper/get_di.dart' as di;


void _setupFCM() async {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission();

  String? token = await messaging.getToken();
  print('FCM Token: $token');

  // Salve esse token no Supabase se quiser enviar notificações segmentadas

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      Get.find<FlutterLocalNotificationsPlugin>().show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'default_channel',
            'Notificações',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }
  });
}

void main() async {
      
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
      url: 'https://mpyyooswcudkgouiomuo.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1weXlvb3N3Y3Vka2dvdWlvbXVvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMwNTk5OTgsImV4cCI6MjA0ODYzNTk5OH0.zjQSRDm22Q8A-hCGyLLd9MObB9pIMCmf9bKg9aaE6AA',
  );
  await GetStorage.init();
  await di.init();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );


  _setupFCM();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      getPages: RouteHelper.routes,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.light,
      locale: const Locale('pt', 'BR'), 
      fallbackLocale: const Locale('en', 'US'),
      home: AuthGate(), 
    );
  }

}

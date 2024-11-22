import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shadow_crawler/firebase_options.dart';

const String vapidKey =
    "BOqJVfjZbEhOPxKz9kJDqE6orUpaHQKFK56IZissdi8GDRWN1MZSAIiu7DMm4IpJl5Wd0gSldcier2tBTeNl0Dw";

const TextScaler textScaler = TextScaler.linear(2);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed() async {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        print('User denied permisson!');
        return;
      }
      await messaging.getToken(vapidKey: vapidKey);

      print('User granted permission: ${settings.authorizationStatus}');
    }

    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      home: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: onPressed,
            child: const Text(
              "Request\nPermission",
              textScaler: textScaler,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

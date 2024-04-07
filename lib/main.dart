import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Ui/phone_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBzU7uwDBtHaqq95JQ8mXkOnlvV7QkOkyg",
          appId: "1:4504 86996611:android:6bde8da9df4b63695a55b6",
          messagingSenderId: '', projectId: "totalxproject-190b3",
          storageBucket: "totalxproject-190b3.appspot.com"
      ));

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login());
  }
}
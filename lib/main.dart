import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_management_app/screens/main_screen.dart';
import 'package:task_management_app/utils/session.dart';
import 'package:task_management_app/utils/session_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamController streamController = StreamController();
  Session session = Session();

  @override
  void initState() {
    session.startListener(streamController: streamController, context: context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: const Color(0xfff5f5f5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff4d2189),
          primary: const Color(0xff4d2189),
          secondary: const Color(0xffc21092),
        ),
        fontFamily: 'Kanit',
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: SessionManager(
          streamController: streamController,
          duration: const Duration(seconds: 10),
          context: context,
          child: const MainScreen(title: 'My Tasks')),
    );
  }
}

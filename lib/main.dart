import 'package:flutter/material.dart';
import 'package:task_management_app/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
// #f5e6fd
          // linear-gradient(45deg, rgba(204,21,158,1) 0%, rgba(85,30,150,1) 60%)
          // brightness: Brightness.dark,
        ),
        fontFamily: 'Kanit',
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // ···

          titleMedium: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          // bodyMedium: GoogleFonts.merriweather(),
          // displaySmall: GoogleFonts.pacifico(),
        ),
      ),
      // darkTheme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,brightness: Brightness.dark),
      //   useMaterial3: true,
      // ),
      home: const MainScreen(title: 'My Tasks'),
    );
  }
}

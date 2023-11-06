import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/screens/tasks_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        theme: ThemeData(
          textTheme:  TextTheme(
              bodyLarge: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              bodySmall: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              )),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: Colors.deepPurple.withOpacity(0.7),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple.withOpacity(0.7),
            foregroundColor: Colors.white,
          ),

        ),
        home: const TaskScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Simple Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber)
        ),
      routes: {
        // '/': (context) =>  const SplashScreen(),
        // '/home': (context) => const MySimpleNotes(),
        // '/login': (context) => const LoginScreen(),
        // '/profile': (context) => const ProfileScreen(),
      }
    );
  }
}
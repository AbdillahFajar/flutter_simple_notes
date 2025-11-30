import 'package:flutter/material.dart';
import './screens/splash_screen.dart';
import './screens/my_simple_notes.dart';


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
        '/': (context) =>  const SplashScreen(), //route awal langsung menampilkan splash screen.
        '/home': (context) => const MySimpleNotes(), //route berikutnya, akan langsung menampilkan aplikasi simple note
        // '/login': (context) => const LoginScreen(),
        // '/profile': (context) => const ProfileScreen(),
      }
    );
  }
}



// lib/main.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:authentication/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase initialize
  await Supabase.initialize(
    url: "https://uyoeqornvigpgkvfjjzj.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV5b2Vxb3JudmlncGdrdmZqanpqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTcxMDEzNDEsImV4cCI6MjA3MjY3NzM0MX0.0jEcGSvW7ti6P6GaR06JioBiIFKjZxFgh9Uf9ZCwJIw", // <-- এখানে তোমার key বসাও
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "homeservices",
      home: SplashPage(), 
    );
  }
}

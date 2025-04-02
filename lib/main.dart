import 'package:flutter/material.dart';
import 'presentation/screens/HomeScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://wfzkwqicqeiegoudcdro.supabase.co" ,
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indmemt3cWljcWVpZWdvdWRjZHJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM1ODYyMzYsImV4cCI6MjA1OTE2MjIzNn0.C9ySRTy0eT4yEQNtFgqrnZRWFNqCARQzlFYLHwWcG6w" ,
  );
  runApp(const MyJersey());
}

class MyJersey extends StatelessWidget {
  const MyJersey({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homescreen(),
    );
  }
}

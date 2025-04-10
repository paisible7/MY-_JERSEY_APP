import 'package:flutter/material.dart';
import 'package:myjersey/core/utils/supabase_init.dart';
import 'package:myjersey/presentation/screens/Login_Screen.dart';
import 'package:myjersey/presentation/screens/Signup_Screen.dart';
import 'presentation/screens/Home_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

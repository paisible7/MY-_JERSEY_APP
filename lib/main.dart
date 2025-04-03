import 'package:flutter/material.dart';
import 'package:myjersey/core/utils/supabase_init.dart';
import 'package:myjersey/presentation/screens/Login_Screen.dart';
import 'package:myjersey/presentation/screens/Signup_Screen.dart';
import 'presentation/screens/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  runApp(const MyJersey());
}

class MyJersey extends StatelessWidget {
  const MyJersey({super.key});

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

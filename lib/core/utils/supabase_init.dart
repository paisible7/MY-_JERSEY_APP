import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: "https://wfzkwqicqeiegoudcdro.supabase.co" ,
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indmemt3cWljcWVpZWdvdWRjZHJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM1ODYyMzYsImV4cCI6MjA1OTE2MjIzNn0.C9ySRTy0eT4yEQNtFgqrnZRWFNqCARQzlFYLHwWcG6w" ,
    );
  }
}
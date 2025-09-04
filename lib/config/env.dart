import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get supabaseUrl {
    try {
      return dotenv.env['SUPABASE_URL'] ??
          'https://ifvbopagsruolzavfrcn.supabase.co';
    } catch (e) {
      return 'https://ifvbopagsruolzavfrcn.supabase.co';
    }
  }

  static String get supabaseAnonKey {
    try {
      return dotenv.env['SUPABASE_ANON_KEY'] ??
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlmdmJvcGFnc3J1b2x6YXZmcmNuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY5MzQ5NTUsImV4cCI6MjA3MjUxMDk1NX0.OpEdNMR8lblHv2UU6oj7NzsfdSCuOECu7M5gsMN0g6g';
    } catch (e) {
      return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlmdmJvcGFnc3J1b2x6YXZmcmNuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY5MzQ5NTUsImV4cCI6MjA3MjUxMDk1NX0.OpEdNMR8lblHv2UU6oj7NzsfdSCuOECu7M5gsMN0g6g';
    }
  }

  static const String googleMapsApiKey =
      'AIzaSyA5X9eJe3Ih4Yfo4txSQzScZmVZpoO8mf8';

  static String get resendApiKey {
    try {
      return dotenv.env['RESEND_API_KEY'] ?? 'your_resend_api_key_here';
    } catch (e) {
      return 'your_resend_api_key_here';
    }
  }
}

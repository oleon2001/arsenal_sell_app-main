import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get supabaseUrl {
    try {
      return dotenv.env['SUPABASE_URL'] ??
          'https://vxlgqalehtocxqkrvfuy.supabase.co';
    } catch (e) {
      return 'https://vxlgqalehtocxqkrvfuy.supabase.co';
    }
  }

  static String get supabaseAnonKey {
    try {
      return dotenv.env['SUPABASE_ANON_KEY'] ??
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ4bGdxYWxlaHRvY3hxa3J2ZnV5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY4NDc0OTMsImV4cCI6MjA3MjQyMzQ5M30._rBuxCDe9kCLt5k3YTq33zXMCR3yIxhBZCPNHkeDccU';
    } catch (e) {
      return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ4bGdxYWxlaHRvY3hxa3J2ZnV5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY4NDc0OTMsImV4cCI6MjA3MjQyMzQ5M30._rBuxCDe9kCLt5k3YTq33zXMCR3yIxhBZCPNHkeDccU';
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

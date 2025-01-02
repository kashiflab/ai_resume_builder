import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration service
class EnvConfig {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  static String get supabaseServiceRoleKey =>
      dotenv.env['SUPABASE_SERVICE_ROLE_KEY'] ?? '';

  /// Initialize environment configuration
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }
}

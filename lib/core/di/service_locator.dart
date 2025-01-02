import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env_config.dart';
import '../network/network_info.dart';
import '../../features/auth/data/repositories/supabase_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final GetIt sl = GetIt.instance;

/// Initialize all dependencies
Future<void> setupServiceLocator() async {
  // External Dependencies
  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
  );
  sl.registerLazySingleton(() => Supabase.instance.client);
  sl.registerLazySingleton(() => const NetworkInfo());

  // Core
  // TODO: Add core dependencies like NetworkInfo, etc.

  // Features
  await _setupAuthFeature();
  await _setupResumeFeature();
  await _setupProfileFeature();
}

/// Setup dependencies for Auth feature
Future<void> _setupAuthFeature() async {
  // BLoCs
  sl.registerFactory(() => AuthBloc(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => SupabaseAuthRepository(sl()),
  );
}

/// Setup dependencies for Resume feature
Future<void> _setupResumeFeature() async {
  // BLoCs
  // TODO: Register resume-related BLoCs

  // Use Cases
  // TODO: Register resume-related use cases

  // Repositories
  // TODO: Register resume-related repositories

  // Data Sources
  // TODO: Register resume-related data sources
}

/// Setup dependencies for Profile feature
Future<void> _setupProfileFeature() async {
  // BLoCs
  // TODO: Register profile-related BLoCs

  // Use Cases
  // TODO: Register profile-related use cases

  // Repositories
  // TODO: Register profile-related repositories

  // Data Sources
  // TODO: Register profile-related data sources
}

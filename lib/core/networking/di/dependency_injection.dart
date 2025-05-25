import 'package:get_it/get_it.dart';
import 'package:osp/core/networking/supabase/subabaseService.dart';
import 'package:osp/features/auth/cubit/auth_cubit.dart';
import 'package:osp/features/auth/data/repos/user_repository.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Register SupabaseService as a lazy singleton
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());

  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  getIt.registerLazySingleton<AuthCubit>(
      () => AuthCubit(getIt.get<UserRepository>()));
}

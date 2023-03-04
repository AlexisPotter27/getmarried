import 'package:get_it/get_it.dart';
import 'package:getmarried/data/repositories/remote/auth/auth_repository.dart';
import 'package:getmarried/data/repositories/remote/auth/auth_repository_impl.dart';
import 'package:getmarried/data/repositories/remote/profile/profile_repository.dart';
import 'package:getmarried/data/repositories/remote/profile/profile_repository_impl.dart';

void setUp(GetIt getIt) {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerSingleton<ProfileRepository>(ProfileRepositoryImpl());
}

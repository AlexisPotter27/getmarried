import 'package:get_it/get_it.dart';
import 'package:getmarried/admin/data/repository/admin_repository_impl.dart';
import 'package:getmarried/admin/dormain/repository/admin_repository.dart';
import 'package:getmarried/data/repositories/remote/auth/auth_repository.dart';
import 'package:getmarried/data/repositories/remote/auth/auth_repository_impl.dart';
import 'package:getmarried/data/repositories/remote/matching_repository/matching_repository.dart';
import 'package:getmarried/data/repositories/remote/matching_repository/matching_repository_impl.dart';
import 'package:getmarried/data/repositories/remote/profile/profile_repository.dart';
import 'package:getmarried/data/repositories/remote/profile/profile_repository_impl.dart';

void setUp(GetIt getIt) {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerSingleton<ProfileRepository>(
    ProfileRepositoryImpl(),
  );
  getIt.registerSingleton<MatchingRepository>(
    MatchingRepositoryImpl(),
  );
  getIt.registerSingleton<AdminRepository>(
    AdminRepositoryImpl(),
  );
}

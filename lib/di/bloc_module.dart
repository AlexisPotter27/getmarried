
import 'package:get_it/get_it.dart';
import 'package:getmarried/admin/presentation/bloc/admin/admin_bloc.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';

void setUp(GetIt getIt){
  getIt.registerLazySingleton(() => AuthBloc(getIt.get()));
  getIt.registerLazySingleton(() => AdminBloc(getIt.get()));
}
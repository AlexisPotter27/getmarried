import 'package:get_it/get_it.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';

void setUp(GetIt getIt) {
  getIt.registerLazySingleton(() => CacheCubit(getIt.get()));
}

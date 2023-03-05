import 'package:get_it/get_it.dart';
import 'package:getmarried/di/cache_module.dart' as cacheModule;
import 'package:getmarried/di/repository_module.dart' as repository;
import 'package:getmarried/di/bloc_module.dart' as blocModule;

GetIt getIt = GetIt.instance;

void init() {
  repository.setUp(getIt);
  blocModule.setUp(getIt);
  cacheModule.setUp(getIt);
}

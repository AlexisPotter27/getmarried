
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getmarried/data/repositories/remote/profile/profile_repository.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';

part 'cache_state.dart';

class CacheCubit extends Cubit<CacheState> {
  CacheCubit() : super(CacheInitial());

  UserData? user;

  void updateUser(UserData userData) async {
    await getIt
        .get<ProfileRepository>()
        .cacheUser(userData);
  }

  Future getCachedUser() async {
    user = await getIt.get<ProfileRepository>().getUserProfile();

  }
}

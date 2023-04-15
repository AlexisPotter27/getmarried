import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getmarried/data/repositories/remote/profile/profile_repository.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';

part 'cache_state.dart';

class CacheCubit extends Cubit<CacheState> {
  CacheCubit(this.profileRepository) : super(CacheInitial());
  final ProfileRepository profileRepository;

  UserData? user;
  void updateUser(UserData userData) async {
    await getIt.get<ProfileRepository>().cacheUser(userData);
    await getCachedUser();
  }
  Future getCachedUser() async {
    user = await profileRepository.getLocalUserProfile();
    emit(ProfileUpdatedState(user!));
  }

}

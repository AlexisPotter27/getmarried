part of 'cache_cubit.dart';

abstract class CacheState extends Equatable {
  const CacheState();
}

class CacheInitial extends CacheState {
  @override
  List<Object> get props => [];
}

class ProfileUpdatedState extends CacheState {
  UserData userData;

  ProfileUpdatedState(this.userData);

  @override
  List<Object?> get props => [userData];
}

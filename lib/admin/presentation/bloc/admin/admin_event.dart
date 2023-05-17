part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
}

class DisableUserEvent extends AdminEvent {
  String uid;

  DisableUserEvent(this.uid);

  @override
  List<Object?> get props => [uid];
}

class UnblockUserEvent extends AdminEvent {
  String uid;

  UnblockUserEvent(this.uid);

  @override
  List<Object?> get props => [];
}

class GetUsersEvent extends AdminEvent {
  @override
  List<Object?> get props => [];
}

class GetReportsEvent extends AdminEvent {
  @override
  List<Object?> get props => [];
}

class AdminSigninEvent extends AdminEvent {
  final String email;
  final String password;

  AdminSigninEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class UsersFetchedEvent extends AdminEvent {
  final List<UserData> users;

  UsersFetchedEvent(this.users);

  @override
  List<Object?> get props => [users];
}

class ListenToUsersStreamEvent extends AdminEvent {
  ListenToUsersStreamEvent();

  @override
  List<Object?> get props => [];
}

class DeleteUserEvent extends AdminEvent {
  final String uid;

  DeleteUserEvent(this.uid);

  @override

  List<Object?> get props => [uid];
}

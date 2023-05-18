part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();
}

class AdminInitial extends AdminState {
  @override
  List<Object> get props => [];
}

class GetAllUsersSuccessState extends AdminState {
  List<UserData> users;

  @override
  List<Object?> get props => [];

  GetAllUsersSuccessState(this.users);
}

class GetAllUsersLoadingState extends AdminState {
  @override
  List<Object?> get props => [];

  GetAllUsersLoadingState();
}

class GetAllUsersFailureState extends AdminState {
  final String error;

  @override
  List<Object?> get props => [error];

  GetAllUsersFailureState(this.error);
}

class GetAllReportsSuccessState extends AdminState {
  List<Report> reports;

  @override
  List<Object?> get props => [];

  GetAllReportsSuccessState(this.reports);
}

class GetAllReportsLoadingState extends AdminState {
  @override
  List<Object?> get props => [];

  GetAllReportsLoadingState();
}

class GetAllReportsFailureState extends AdminState {
  final String error;

  @override
  List<Object?> get props => [error];

  GetAllReportsFailureState(this.error);
}

class DisableUserSuccessState extends AdminState {
  @override
  List<Object?> get props => [];

  DisableUserSuccessState();
}

class DisableUserLoadingState extends AdminState {
  @override
  List<Object?> get props => [];

  DisableUserLoadingState();
}

class DisableUserFailureState extends AdminState {
  final String error;

  @override
  List<Object?> get props => [error];

  DisableUserFailureState(this.error);
}

class UnblockUserSuccessState extends AdminState {
  @override
  List<Object?> get props => [];

  UnblockUserSuccessState();
}

class UnblockUserLoadingState extends AdminState {
  @override
  List<Object?> get props => [];

  UnblockUserLoadingState();
}

class UnblockUserFailureState extends AdminState {
  final String error;

  @override
  List<Object?> get props => [error];

  UnblockUserFailureState(this.error);
}

class AdminSigninSuccessState extends AdminState {
  String success;

  @override
  List<Object?> get props => [];

  AdminSigninSuccessState(this.success);
}

class AdminSigninLoadingState extends AdminState {
  @override
  List<Object?> get props => [];

  AdminSigninLoadingState();
}

class AdminSigninFailureState extends AdminState {
  final String error;

  @override
  List<Object?> get props => [error];

  AdminSigninFailureState(this.error);
}

class UsersFetchedState extends AdminState {
  final List<UserData> users;


  @override
  List<Object?> get props => [users];

  UsersFetchedState(this.users);
}

class DeleteUserLoadingState extends AdminState {
  @override
  List<Object> get props => [];

  const DeleteUserLoadingState();
}

class DeleteUserSuccessState extends AdminState {
  @override
  List<Object> get props => [];

  const DeleteUserSuccessState();
}

class DeleteUserFailureState extends AdminState {
  final String error;

  @override
  List<Object> get props => [error];

  const DeleteUserFailureState(this.error);
}


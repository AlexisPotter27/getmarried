part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class SmsSentState extends AuthState {
  final String verificationID;
  final String? resendToken;

  const SmsSentState(this.verificationID, this.resendToken);
}

class SendSmsLoadingState extends AuthState {}

class SendSmsFailedState extends AuthState {
  final String error;

  @override
  List<Object> get props => [error];

  const SendSmsFailedState(this.error);
}

class SmsVerificationCompletedState extends AuthState {
  final PhoneAuthCredential credential;

  const SmsVerificationCompletedState(this.credential);
}

class PhoneAuthLoadingState extends AuthState {}

class PhoneAuthSuccessState extends AuthState {
  final UserData userData;

  @override
  List<Object> get props => [userData];

  const PhoneAuthSuccessState(this.userData);
}

class PhoneAuthFailureState extends AuthState {
  final String error;

  @override
  List<Object> get props => [error];

  const PhoneAuthFailureState(this.error);
}

class UpdateUserLoadingState extends AuthState {
  @override
  List<Object> get props => [];

  const UpdateUserLoadingState();
}

class UpdateUserSuccessState extends AuthState {
  final UserData userData;

  @override
  List<Object> get props => [userData];

  const UpdateUserSuccessState(this.userData);
}

class UpdateUserFailureState extends AuthState {
  final String error;

  @override
  List<Object> get props => [error];

  const UpdateUserFailureState(this.error);
}

class UpdateUserImageLoadingState extends AuthState {
  @override
  List<Object> get props => [];

  const UpdateUserImageLoadingState();
}

class UpdateUserImageSuccessState extends AuthState {
  final List<String> userImages;

  @override
  List<Object> get props => [userImages];

  const UpdateUserImageSuccessState(this.userImages);
}

class UpdateUserImageFailureState extends AuthState {
  final String error;

  @override
  List<Object> get props => [error];

  const UpdateUserImageFailureState(this.error);
}

class DeleteUserLoadingState extends AuthState {
  @override
  List<Object> get props => [];

  const DeleteUserLoadingState();
}

class DeleteUserSuccessState extends AuthState {
  @override
  List<Object> get props => [];

  const DeleteUserSuccessState();
}

class DeleteUserFailureState extends AuthState {
  final String error;

  @override
  List<Object> get props => [error];

  const DeleteUserFailureState(this.error);
}

class GoogleSignInLoadingState extends AuthState {
  @override
  List<Object> get props => [];

  const GoogleSignInLoadingState();
}

class GoogleSignInSuccessState extends AuthState {
  final UserData user;

  @override
  List<Object> get props => [];

  const GoogleSignInSuccessState(this.user);
}

class GoogleSignInFailureState extends AuthState {
  final String error;

  @override
  List<Object> get props => [error];

  const GoogleSignInFailureState(this.error);
}

class FacebookSignInLoadingState extends AuthState {
  @override
  List<Object> get props => [];

  const FacebookSignInLoadingState();
}

class FacebookSignInSuccessState extends AuthState {
  final UserData user;

  @override
  List<Object> get props => [];

  const FacebookSignInSuccessState(this.user);
}

class FacebookSignInFailedState extends AuthState {
  final String error;

  @override
  List<Object> get props => [error];

  const FacebookSignInFailedState(this.error);
}


class AppleSignInLoadingState extends AuthState {
  @override
  List<Object> get props => [];

  const AppleSignInLoadingState();
}

class AppleSignInSuccessState extends AuthState {
  final UserData user;

  @override
  List<Object> get props => [];

  const AppleSignInSuccessState(this.user);
}

class AppleSignInFailureState extends AuthState {
  final String error;

  @override
  List<Object> get props => [error];

  const AppleSignInFailureState(this.error);
}


class AuthStateChangedState extends AuthState{
  String? uid;
  @override
  List<Object?> get props => [uid];

  AuthStateChangedState(this.uid);
}

class AccountDisabledState extends AuthState{
  String? uid;
  @override
  List<Object?> get props => [uid];

  AccountDisabledState(this.uid);
}

class AccountDeletedState extends AuthState{
  String? uid;
  @override
  List<Object?> get props => [uid];

  AccountDeletedState(this.uid);
}

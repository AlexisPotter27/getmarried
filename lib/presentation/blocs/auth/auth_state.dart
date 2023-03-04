part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
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

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String number;
  final String? resendToken;

  const SendOtpEvent({required this.number, this.resendToken});

  @override
  List<Object> get props => [
        number,
      ];
}

class OtpSentEvent extends AuthEvent {
  final String verificationId;
  final String resendToken;

  const OtpSentEvent({required this.verificationId, required this.resendToken});

  @override
  List<Object> get props => [verificationId, resendToken];
}

class SenOtpFailedEvent extends AuthEvent {
  final String error;

  const SenOtpFailedEvent({required this.error});

  @override
  List<Object> get props => [
        error,
      ];
}

// class VerifyNumberEvent extends AuthEvent {
//   final PhoneAuthCredential credential;
//
//   const VerifyNumberEvent({required this.credential});
//
//   @override
//   List<Object> get props => [credential,];
// }

class PhoneNumberSigninEvent extends AuthEvent {
  final PhoneAuthCredential credential;

  const PhoneNumberSigninEvent(this.credential);
}

class UpdateUserEvent extends AuthEvent {
  final UserData userData;
  const UpdateUserEvent(this.userData);
}

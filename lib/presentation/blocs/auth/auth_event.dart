part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
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

class GoogleSigninEvent extends AuthEvent {
  const GoogleSigninEvent();
}

class UpdateUserEvent extends AuthEvent {
  final UserData userData;
  List<XFile>? images;

  UpdateUserEvent(this.userData, {this.images = const []});
}

class DeleteUserEvent extends AuthEvent {
  final String uid;

  DeleteUserEvent(this.uid);
}

class UpdateUserImageEvent extends AuthEvent {
  List<XFile>? images;

  UpdateUserImageEvent({this.images = const []});
}

class FacebookSigninEvent extends AuthEvent {
  FacebookSigninEvent();
}

class AppleSigninEvent extends AuthEvent {
  AppleSigninEvent();
}

class UpdateUserTokenEvent extends AuthEvent {
  String uid;

  UpdateUserTokenEvent({required this.uid});
}

class AuthStateChangedEvent extends AuthEvent {
  String? uid;

  @override
  List<Object?> get props => [uid];

  AuthStateChangedEvent(this.uid);
}

class ListenToUserAccountEvent extends AuthEvent {
  String? uid;

  @override
  List<Object?> get props => [uid];

  ListenToUserAccountEvent(this.uid);
}

class AccountDisabledEvent extends AuthEvent {
  String? uid;

  @override
  List<Object?> get props => [uid];

  AccountDisabledEvent(this.uid);
}

class AccountDeletedEvent extends AuthEvent {
  String? uid;

  @override
  List<Object?> get props => [uid];

  AccountDeletedEvent(this.uid);
}

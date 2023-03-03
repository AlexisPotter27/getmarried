part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class VerifyNumberEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SendOtpEvent extends AuthEvent {
 final String number;
  String? resendToken;

  SendOtpEvent({required this.number, this.resendToken});

  @override
  List<Object> get props => [number,];
}

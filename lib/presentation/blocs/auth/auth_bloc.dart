import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/data/repositories/remote/auth/auth_repository.dart';
import 'package:getmarried/models/user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  FirebaseAuth auth = FirebaseAuth.instance;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<SendOtpEvent>(_mapSendOtpEventToState);
    on<SenOtpFailedEvent>(_mapSendOtpFailedState);
    on<OtpSentEvent>((event, emit) =>
        emit(SmsSentState(event.verificationId, event.resendToken)));
    // on<VerificationCompletedEvent>(
    //     (event, emit) => add(PhoneNumberSigninEvent(event.credential)));

    on<PhoneNumberSigninEvent>(_mapPhoneNumberSignin);
  }

  FutureOr<void> _mapSendOtpEventToState(
      SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(SendSmsLoadingState());
    try {
      await authRepository.sendSms(
          number: event.number,
          resendToken: event.resendToken,
          onVerificationFailed: (FirebaseAuthException exception) {
            // emit(SendSmsFailedState(exception.code));
            add(SenOtpFailedEvent(error: exception.code));
            // log(exception.code);
          },
          onVerificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
            add(PhoneNumberSigninEvent(phoneAuthCredential));
          },
          onCodeSent: (verificationId, resendToken) {
            add(OtpSentEvent(
                verificationId: verificationId,
                resendToken: resendToken.toString()));
          },
          onCodeAutoRetrievalTimeout: (verificationId) {});
    } on Exception catch (e) {
      // emit(const SendSmsFailedState('Something went wrong please retry'));

    }
  }

  FutureOr<void> _mapSendOtpFailedState(
      SenOtpFailedEvent event, Emitter<AuthState> emit) {
    emit(SendSmsFailedState(event.error));
  }

  FutureOr<void> _mapPhoneNumberSignin(
      PhoneNumberSigninEvent event, Emitter<AuthState> emit) async {
    emit(PhoneAuthLoadingState());

    try {
      ApiResponse response =
          await authRepository.signinWithPhoneNumber(event.credential);
      if (response.error == null) {
        emit(PhoneAuthSuccessState(response.data));
      } else {
        emit(PhoneAuthFailureState(response.error.toString()));
      }
    } on FirebaseAuthException catch (e) {
      emit(PhoneAuthFailureState(e.code));
    } catch (e) {
      emit(PhoneAuthFailureState(e.toString()));
    }
  }
}

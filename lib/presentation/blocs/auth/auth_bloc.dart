import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/data/repositories/remote/auth/auth_repository.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/services/push_notification_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  FirebaseAuth auth = FirebaseAuth.instance;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    startListeningToUserData();

    on<AuthEvent>((event, emit) {});

    on<SendOtpEvent>(_mapSendOtpEventToState);
    on<SenOtpFailedEvent>(_mapSendOtpFailedState);
    on<OtpSentEvent>((event, emit) =>
        emit(SmsSentState(event.verificationId, event.resendToken)));
    // on<VerificationCompletedEvent>(
    //     (event, emit) => add(PhoneNumberSigninEvent(event.credential)));
    on<PhoneNumberSigninEvent>(_mapPhoneNumberSignin);
    on<GoogleSigninEvent>(_mapGoogleSigninEventToState);
    on<AppleSigninEvent>(_mapAppleSigninEventToState);
    on<FacebookSigninEvent>(_mapFaceBookSigninEventToState);
    on<UpdateUserEvent>(_mapUpdateUserEventToState);
    on<DeleteUserEvent>(_mapDeleteUserEventToState);
    on<UpdateUserImageEvent>(_mapUpdateUserImageEventToState);
    on<UpdateUserTokenEvent>(_mapUpdateUserTokenEventToState);
    on<ListenToUserAccountEvent>(_mapListenToUserAccountEventToState);
    on<AccountDeletedEvent>((event, emit) => emit(AccountDeletedState(event.uid)));
    on<AccountDisabledEvent>((event, emit) => emit(AccountDisabledState(event.uid)));
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

  FutureOr<void> _mapUpdateUserEventToState(
      UpdateUserEvent event, Emitter<AuthState> emit) async {
    emit(const UpdateUserLoadingState());

    try {
      var deviceId = await PushNotificationService.getDeviceToken();

      ApiResponse response = await authRepository.updateUser(
          event.userData.copyWith(deviceId: deviceId), event.images);

      if (response.error == null) {
        emit(UpdateUserSuccessState(response.data));
      } else {
        log(response.error.toString());
        emit(UpdateUserFailureState(response.error));
      }
    } on Exception catch (e) {
      emit(UpdateUserFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapUpdateUserImageEventToState(
      UpdateUserImageEvent event, Emitter<AuthState> emit) async {
    emit(const UpdateUserImageLoadingState());

    try {
      ApiResponse response =
          await authRepository.uploadUserImages(event.images);
      if (response.error == null) {
        emit(UpdateUserImageSuccessState(response.data));
      } else {
        log(response.error.toString());
        emit(UpdateUserImageFailureState(response.error));
      }
    } on Exception catch (e) {
      emit(UpdateUserImageFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapDeleteUserEventToState(
      DeleteUserEvent event, Emitter<AuthState> emit) async {
    emit(const DeleteUserLoadingState());

    try {
      ApiResponse response = await authRepository.deleteUser(event.uid);
      if (response.error == null) {
        emit(DeleteUserSuccessState());
      } else {
        log(response.error.toString());
        emit(DeleteUserFailureState(response.error.toString()));
      }
    } on Exception catch (e) {
      emit(DeleteUserFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapGoogleSigninEventToState(
      GoogleSigninEvent event, Emitter<AuthState> emit) async {
    emit(GoogleSignInLoadingState());

    try {
      ApiResponse response = await authRepository.signInWithGoogle();
      if (response.error == null) {
        emit(GoogleSignInSuccessState(response.data));
      } else {
        emit(GoogleSignInFailureState(response.error.toString()));
      }
    } on FirebaseAuthException catch (e) {
      emit(GoogleSignInFailureState(e.code));
    } catch (e) {
      emit(GoogleSignInFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapFaceBookSigninEventToState(
      FacebookSigninEvent event, Emitter<AuthState> emit) async {
    emit(FacebookSignInLoadingState());

    try {
      ApiResponse response = await authRepository.signInWithFacebook();
      if (response.error == null) {
        emit(FacebookSignInSuccessState(response.data));
      } else {
        emit(FacebookSignInFailedState(response.error.toString()));
      }
    } on FirebaseAuthException catch (e) {
      emit(FacebookSignInFailedState(e.code));
    } catch (e) {
      emit(FacebookSignInFailedState(e.toString()));
    }
  }

  FutureOr<void> _mapAppleSigninEventToState(
      AppleSigninEvent event, Emitter<AuthState> emit) async {
    emit(AppleSignInLoadingState());

    try {
      ApiResponse response = await authRepository.signInWithAppleId();
      if (response.error == null) {
        emit(AppleSignInSuccessState(response.data));
      } else {
        emit(AppleSignInFailureState(response.error.toString()));
      }
    } on FirebaseAuthException catch (e) {
      emit(AppleSignInFailureState(e.code));
    } on SignInWithAppleAuthorizationException catch (e) {
      emit(AppleSignInFailureState(e.message));
    } catch (e) {
      emit(AppleSignInFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapUpdateUserTokenEventToState(
      UpdateUserTokenEvent event, Emitter<AuthState> emit) async {
    try {
      ApiResponse response = await authRepository.updateUserToken(event.uid);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void startListeningToUserData() {
    authRepository.authState().listen((event) {
      if (event?.uid != null) {
        log('USER ${'LISTENING : EVENT ID IS NOT  NULL'}${event!.uid}');
        add((AuthStateChangedEvent(event.uid)));
      } else if (event?.uid == null) {
        log('USER ${'LISTENING :EVENT ID IS  NULL'}');
        add((AuthStateChangedEvent(null)));
      }
    });
  }

  FutureOr<void> _mapListenToUserAccountEventToState(
      ListenToUserAccountEvent listenEvent, Emitter<AuthState> emit) {
    log('STARTED LISTENING TO USER ACCOUNT');
    authRepository.userStream(auth.currentUser!.uid).listen((event) {
      log(event.exists.toString());
      if (event.exists) {
        UserData userData = UserData.fromJson(event.data()!);
        if (userData.accountDisabled! == false) {
          getIt.get<CacheCubit>().updateUser(userData);
        } else {
          add(AccountDisabledEvent(listenEvent.uid));
        }
      } else {
        getIt.get<AuthBloc>().add(AccountDeletedEvent(listenEvent.uid));
      }
    });
  }
}

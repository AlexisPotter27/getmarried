import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:getmarried/admin/data/models/get_reports_response.dart';
import 'package:getmarried/admin/data/models/report.dart';
import 'package:getmarried/admin/dormain/repository/admin_repository.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/models/user.dart';

part 'admin_event.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepository;
  StreamSubscription? usersSubscription;

  AdminBloc(this.adminRepository) : super(AdminInitial()) {
    on<AdminEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetUsersEvent>(_mapUsersEventToState);
    on<GetReportsEvent>(_mapGetReportsEventToState);
    on<DisableUserEvent>(_mapDisableUserEventToState);
    on<UnblockUserEvent>(_mapUnblockUserEventToState);
    on<AdminSigninEvent>(_mapSigninEventToState);
    on<DeleteUserEvent>(_mapDeleteUserEventToState);
    on<ListenToUsersStreamEvent>(_mapListenToUsersStreamEventToState);
    on<UsersFetchedEvent>(
        (event, emit) => emit(UsersFetchedState(event.users)));
  }

  FutureOr<void> _mapUsersEventToState(
      GetUsersEvent event, Emitter<AdminState> emit) async {
    emit(GetAllUsersLoadingState());
    try {
      ApiResponse response = await adminRepository.getAllUsers();
      if (response.error == null) {
        emit(GetAllUsersSuccessState(response.data));
      }
    } on FirebaseException catch (e) {
      log(e.code);

      emit(GetAllUsersFailureState(e.code));
    } catch (e, stack) {
      log(stack.toString());
      emit(GetAllUsersFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapDisableUserEventToState(
      DisableUserEvent event, Emitter<AdminState> emit) async {
    emit(DisableUserLoadingState());
    try {
      ApiResponse response = await adminRepository.disableUser(event.uid);

      emit(DisableUserSuccessState());
    } on FirebaseException catch (e) {
      emit(DisableUserFailureState(e.code));
    } catch (e) {
      emit(DisableUserFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapGetReportsEventToState(
      GetReportsEvent event, Emitter<AdminState> emit) async {
    emit(GetAllReportsLoadingState());
    try {
      log('loading');
      ApiResponse response = await adminRepository.getAllReports();

      if (response.error == null) {
        emit(GetAllReportsSuccessState(response.data));
      } else {
        emit(GetAllReportsFailureState(response.error));
      }
    } on FirebaseException catch (e) {
      emit(GetAllReportsFailureState(e.code));
    } catch (e) {
      emit(GetAllReportsFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapUnblockUserEventToState(
      UnblockUserEvent event, Emitter<AdminState> emit) async {
    emit(UnblockUserLoadingState());
    try {
      await adminRepository.unblockUser(event.uid);

      emit(UnblockUserSuccessState());
      log('UserUnblocked');
    } on FirebaseException catch (e) {
      emit(UnblockUserFailureState(e.code));
    } catch (e) {
      emit(UnblockUserFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapSigninEventToState(
      AdminSigninEvent event, Emitter<AdminState> emit) async {
    emit(AdminSigninLoadingState());
    try {
      var response =
          await adminRepository.signinAdmin(event.email, event.password);

      if (response.error == null) {
        emit(AdminSigninSuccessState(response.data));
      } else {
        emit(AdminSigninFailureState(response.error));
      }
    } on FirebaseException catch (e) {
      emit(AdminSigninFailureState(e.code));
    } catch (e) {
      emit(AdminSigninFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapListenToUsersStreamEventToState(
      ListenToUsersStreamEvent event, Emitter<AdminState> emit) {
    usersSubscription?.cancel();
    usersSubscription =
        adminRepository.getUsersStream().asBroadcastStream().listen((event) {
      log('USERS LENGHT${event.docs.length.toString()}');
      add(UsersFetchedEvent(
          event.docs.map((e) => UserData.fromJson(e.data())).toList()));
    });
  }

  FutureOr<void> _mapDeleteUserEventToState(
      DeleteUserEvent event, Emitter<AdminState> emit) async {
    emit(const DeleteUserLoadingState());

    try {
      ApiResponse response = await adminRepository.deleteUser(event.uid);
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
}

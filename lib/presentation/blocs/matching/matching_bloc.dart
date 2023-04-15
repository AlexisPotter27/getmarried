import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/data/repositories/remote/matching_repository/matching_repository.dart';

part 'matching_event.dart';

part 'matching_state.dart';

class MatchingBloc extends Bloc<MatchingEvent, MatchingState> {
  final MatchingRepository _matchingRepository;

  MatchingBloc(this._matchingRepository) : super(MatchingInitial()) {
    on<MatchingEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LikeUserEvent>(_mapLikeUserEventToState);
    on<DisLikeUserEvent>(_mapDisLikeUserEventToState);
  }

  FutureOr<void> _mapLikeUserEventToState(
      LikeUserEvent event, Emitter<MatchingState> emit) async {
    emit(LikeUserLoadingState());
    try {
      log('loading');

      ApiResponse response =
          await _matchingRepository.like(match: event.match, uid: event.uid);
      log(response.data);

      if (response.error == null) {
        emit(LikeUserSuccessState());
      }
    } on FirebaseException catch (e) {
      emit(LikeUserFailureState(e.code));
    } catch (e) {
      emit(LikeUserFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapDisLikeUserEventToState(
      DisLikeUserEvent event, Emitter<MatchingState> emit) async {
    emit(DisLikeUserLoadingState());
    try {
      log('loading');

      ApiResponse response = await _matchingRepository.disLike(event.uid);
      log(response.data);

      if (response.error == null) {
        emit(DisLikeUserSuccessState());
      }
    } on FirebaseException catch (e) {
      emit(DisLikeUserFailureState(e.code));
    } catch (e) {
      emit(DisLikeUserFailureState(e.toString()));
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';

part 'swipe_event.dart';

part 'swipe_state.dart';

class SwipeController extends Bloc<SwipeEvent, SwipeState> {
  SwipeController() : super(SwipeInitial()) {
    on<SwipeEvent>((event, emit) {});
    on<LikeEvent>(_mapLikeEventToState);
    on<DisLikeEvent>(_mapDisLikeEventToState);
  }

  FutureOr<void> _mapLikeEventToState(
      LikeEvent event, Emitter<SwipeState> emit) {
    emit(SwipedState(SwipeStates.liked));
  }

  FutureOr<void> _mapDisLikeEventToState(
      DisLikeEvent event, Emitter<SwipeState> emit) {
    emit(SwipedState(SwipeStates.disliked));
  }
}

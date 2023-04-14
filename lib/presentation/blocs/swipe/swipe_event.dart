part of 'swipe_bloc.dart';

abstract class SwipeEvent {
  const SwipeEvent();
}

class LikeEvent extends SwipeEvent {}

class DisLikeEvent extends SwipeEvent {}

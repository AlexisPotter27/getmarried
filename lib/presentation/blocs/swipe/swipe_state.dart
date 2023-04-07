part of 'swipe_bloc.dart';

enum SwipeStates { liked, disliked }

abstract class SwipeState {
  const SwipeState();
}

class SwipeInitial extends SwipeState {}

class SwipedState extends SwipeState {
  SwipeStates swipeState;

  SwipedState(this.swipeState);
}

part of 'matching_bloc.dart';

abstract class MatchingState extends Equatable {
  const MatchingState();
}

class MatchingInitial extends MatchingState {
  @override
  List<Object> get props => [];
}

class LikeUserLoadingState extends MatchingState {
  @override
  List<Object> get props => [];
}

class LikeUserSuccessState extends MatchingState {
  @override
  List<Object> get props => [];
}

class LikeUserFailureState extends MatchingState {
  final String error;

  LikeUserFailureState(this.error);

  @override
  List<Object> get props => [error];
}

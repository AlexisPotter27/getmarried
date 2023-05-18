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


class DisLikeUserLoadingState extends MatchingState {
  @override
  List<Object> get props => [];
}

class DisLikeUserSuccessState extends MatchingState {
  @override
  List<Object> get props => [];
}

class DisLikeUserFailureState extends MatchingState {
  final String error;

  DisLikeUserFailureState(this.error);

  @override
  List<Object> get props => [error];
}


class SendReportLoadingState extends MatchingState {
  @override
  List<Object> get props => [];
}

class SendReportSuccessState extends MatchingState {
  @override
  List<Object> get props => [];
}

class SendReportFailureState extends MatchingState {
  final String error;

  SendReportFailureState(this.error);

  @override
  List<Object> get props => [error];
}
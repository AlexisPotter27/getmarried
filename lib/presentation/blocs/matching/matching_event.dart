part of 'matching_bloc.dart';

abstract class MatchingEvent extends Equatable {
  const MatchingEvent();
}

class LikeUserEvent extends MatchingEvent {
  final String uid;
  final bool match;

  LikeUserEvent({required this.uid, this.match = false});

  @override
  List<Object?> get props => [];
}

class DisLikeUserEvent extends MatchingEvent {
  String uid;

  DisLikeUserEvent(this.uid);

  @override
  List<Object?> get props => [];
}

class SendReportEvent extends MatchingEvent {
  final ReportModel reportModel;

  SendReportEvent(this.reportModel);

  @override
  List<Object?> get props => [reportModel];
}

part of 'core_bloc.dart';

abstract class CoreState extends Equatable {
  const CoreState();
}

class CoreInitial extends CoreState {
  @override
  List<Object> get props => [];
}

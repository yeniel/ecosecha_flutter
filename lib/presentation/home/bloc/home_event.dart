part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeSetTabEvent extends HomeEvent {
  const HomeSetTabEvent(this.tab);

  final HomeTab tab;

  @override
  List<Object?> get props => [tab];
}
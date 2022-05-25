part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class CategoriesRequestedEvent extends CategoriesEvent {
  const CategoriesRequestedEvent();

  @override
  List<Object?> get props => [];
}

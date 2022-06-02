part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class CategoriesInitEvent extends CategoriesEvent {
  const CategoriesInitEvent();

  @override
  List<Object?> get props => [];
}

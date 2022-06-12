part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  const CategoriesState({this.categories = const []});

  final List<ProductCategory> categories;

  CategoriesState copyWith({categories}) {
    return CategoriesState(categories: categories);
  }

  @override
  List<Object> get props => [categories];
}

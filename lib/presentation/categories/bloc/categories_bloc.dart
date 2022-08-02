import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({
    required ProductsRepository productsRepository,
    required AnalyticsManager analyticsManager,
  })  : _productsRepository = productsRepository,
        _analyticsManager = analyticsManager,
        super(const CategoriesState()) {
    on<CategoriesInitEvent>(_onCategoriesInitEvent);
    on<CategoryTapEvent>(_onCategoryTapEvent);
  }

  final ProductsRepository _productsRepository;
  final AnalyticsManager _analyticsManager;

  void _onCategoriesInitEvent(CategoriesInitEvent event, Emitter<CategoriesState> emit) {
    var categories = _productsRepository.categories;

    if (categories != null) {
      emit(state.copyWith(categories: categories));
    }
  }

  void _onCategoryTapEvent(CategoryTapEvent event, Emitter<CategoriesState> emit) {
    _analyticsManager.logEvent(CategoryTapAnalyticsEvent(
      categoryId: event.category.id,
      categoryName: event.category.name,
    ));
  }
}

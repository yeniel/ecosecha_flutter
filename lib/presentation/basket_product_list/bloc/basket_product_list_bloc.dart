import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'basket_product_list_event.dart';

part 'basket_product_list_state.dart';

class BasketProductListBloc extends Bloc<BasketProductListEvent, BasketProductListState> {
  BasketProductListBloc({
    Product? basket,
    required ProductsRepository productsRepository,
    required AnalyticsManager analyticsManager,
  })  : _productsRepository = productsRepository,
        _basket = basket ?? Product.empty,
        _analyticsManager = analyticsManager,
        super(BasketProductListState(basket: basket ?? Product.empty)) {
    on<BasketProductListInitEvent>(_onBasketProductListInit);
  }

  final Product _basket;
  final ProductsRepository _productsRepository;
  final AnalyticsManager _analyticsManager;

  void _onBasketProductListInit(BasketProductListInitEvent event, Emitter<BasketProductListState> emit) {
    var products = _productsRepository.getProductsOfBasket(_basket);

    emit(state.copyWith(products: products));
    _analyticsManager.logEvent(BasketProductListPageEvent(basketId: _basket.id, basketName: _basket.name));
  }
}

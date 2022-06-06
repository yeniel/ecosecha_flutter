import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(OrderState()) {
    on<OrderInitEvent>(_onOrderInit);
    on<AddProductEvent>(_onAddProduct);
    on<SubtractProductEvent>(_onSubtractProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  final OrderRepository _orderRepository;

  Future<void> _onOrderInit(OrderInitEvent event, Emitter<OrderState> emit) async {
    var order = await _orderRepository.order;

    _orderRepository.updateOrder(order: order);
    emit(await _getUpdatedState());
  }

  Future<void> _onAddProduct(AddProductEvent event, Emitter<OrderState> emit) async {
    var orderProduct = event.orderProduct.copyWith(quantity: event.orderProduct.quantity + 1);

    _orderRepository.addOrUpdateProduct(orderProduct: orderProduct);
    emit(await _getUpdatedState());
  }

  Future<void> _onSubtractProduct(SubtractProductEvent event, Emitter<OrderState> emit) async {
    var orderProduct = event.orderProduct.copyWith(quantity: event.orderProduct.quantity - 1);

    _orderRepository.addOrUpdateProduct(orderProduct: orderProduct);
    emit(await _getUpdatedState());
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<OrderState> emit) async {
    _orderRepository.deleteProduct(orderProduct: event.orderProduct);
    emit(await _getUpdatedState());
  }

  Future<OrderState> _getUpdatedState() async {
    var order = await _orderRepository.order;
    var totalPrice = order.products.map((product) {
      return product.quantity * product.product.price;
    }).reduce((value, element) => value + element);
    var totalPriceRounded = double.parse(totalPrice.toStringAsFixed(2));

    return state.copyWith(order: order, totalPrice: totalPriceRounded);
  }
}

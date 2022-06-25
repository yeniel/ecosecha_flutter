import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required OrderRepository orderRepository,
    required CompanyRepository companyRepository,
    required UserRepository userRepository,
  })  : _orderRepository = orderRepository,
        _companyRepository = companyRepository,
        _userRepository = userRepository,
        super(OrderState()) {
    on<OrderInitEvent>(_onOrderInit);
    on<AddProductEvent>(_onAddProduct);
    on<SubtractProductEvent>(_onSubtractProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<CancelOrderEvent>(_onCancelOrder);
    on<ConfirmOrderEvent>(_onConfirmOrder);
  }

  final OrderRepository _orderRepository;
  final CompanyRepository _companyRepository;
  final UserRepository _userRepository;

  Future<void> _onOrderInit(OrderInitEvent event, Emitter<OrderState> emit) async {
    await emit.forEach<Order>(
      _orderRepository.order,
      onData: (order) {
        var confirmed = _orderRepository.isConfirmed;
        var totalAmount = _calculateTotalAmount(order);
        var company = _companyRepository.company;

        return state.copyWith(
          order: order,
          totalAmount: totalAmount,
          confirmed: confirmed,
          minimumAmount: company?.minimumAmount,
        );
      },
      onError: (_, __) => state,
    );
  }

  double _calculateTotalAmount(Order order) {
    var productAmountList = order.products.map((product) {
      return product.quantity * product.product.price;
    });

    var totalAmount = productAmountList.isEmpty ? 0 : productAmountList.reduce((value, element) => value + element);

    var totalAmountRounded = double.parse(totalAmount.toStringAsFixed(2));

    return totalAmountRounded;
  }

  Future<void> _onAddProduct(AddProductEvent event, Emitter<OrderState> emit) async {
    var orderProduct = event.orderProduct.copyWith(quantity: event.orderProduct.quantity + 1);

    _orderRepository.addOrUpdateProduct(orderProduct: orderProduct);
  }

  Future<void> _onSubtractProduct(SubtractProductEvent event, Emitter<OrderState> emit) async {
    var orderProduct = event.orderProduct.copyWith(quantity: event.orderProduct.quantity - 1);

    _orderRepository.addOrUpdateProduct(orderProduct: orderProduct);
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<OrderState> emit) async {
    _orderRepository.deleteProduct(orderProduct: event.orderProduct);
  }

  Future<void> _onCancelOrder(CancelOrderEvent event, Emitter<OrderState> emit) async {
    var company = _companyRepository.company;
    var user = _userRepository.user;
    var subject = 'Cancelar Pedido';
    var body = 'Hola: Quisiera cancelar mi pedido.\n\nUsuario: ${user?.id}\nEmail: ${user?.email}';

    var url = Uri(
      scheme: 'mailto',
      path: company?.email,
      query: 'subject=$subject&body=$body',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> _onConfirmOrder(ConfirmOrderEvent event, Emitter<OrderState> emit) async {
    await _orderRepository.confirmOrder();
  }
}

import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required OrderRepository orderRepository,
    required CompanyRepository companyRepository,
    required UserRepository userRepository,
    required AnalyticsManager analyticsManager,
  })  : _orderRepository = orderRepository,
        _companyRepository = companyRepository,
        _userRepository = userRepository,
        _analyticsManager = analyticsManager,
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
  final AnalyticsManager _analyticsManager;
  Order? _initialOrder;

  bool get canChangeOrder {
    return _userRepository.user?.orderWarning == 'Ok';
  }

  Future<void> _onOrderInit(OrderInitEvent event, Emitter<OrderState> emit) async {
    await emit.forEach<Order>(
      _orderRepository.order,
      onData: (order) {
        var totalAmount = _calculateTotalAmount(order);
        var company = _companyRepository.company;
        var status = OrderPageStatus.init;
        String? error;

        _initialOrder ??= Order(
          products: List.from(order.products),
          date: order.date,
          deliveryGroup: order.deliveryGroup,
        );

        var canConfirm = _initialOrder != order && order.products.isNotEmpty && canChangeOrder;
        var canCancel = canChangeOrder && !_orderRepository.isCancelled;

        if (!canChangeOrder) {
          error = _userRepository.user?.orderWarning?.split('|').first;
        } else if (_orderRepository.isCancelled) {
          error = 'Pedido cancelado';
        }

        order.products.sort((orderProduct1, orderProduct2) {
          if (orderProduct1.product.type == ProductType.basket) {
            return -1;
          } else {
            return 0;
          }
        });

        return state.copyWith(
          order: order,
          totalAmount: totalAmount,
          canConfirm: canConfirm,
          canCancel: canCancel,
          minimumAmount: company?.minimumAmount,
          pageStatus: status,
          error: error,
        );
      },
      onError: (_, __) => state,
    );
  }

  double _calculateTotalAmount(Order order) {
    var totalAmount = 0.0;

    if (order.products.isNotEmpty) {
      totalAmount = order.products.map((e) => e.amount).reduce((value, element) => value + element);
    }

    var totalAmountRounded = double.parse(totalAmount.toStringAsFixed(2));

    return totalAmountRounded;
  }

  Future<void> _onAddProduct(AddProductEvent event, Emitter<OrderState> emit) async {
    if (canChangeOrder) {
      var orderProduct = event.orderProduct.copyWith(quantity: event.orderProduct.quantity + 1);

      _orderRepository.addOrUpdateProduct(orderProduct: orderProduct);
      _analyticsManager.logEvent(AddProductAnalyticsEvent(
        productId: orderProduct.product.id,
        productName: orderProduct.product.name,
      ));
    } else {
      emit(state.copyWith(pageStatus: OrderPageStatus.canNotChangeError, toggleState: !state.toggleState));
    }
  }

  Future<void> _onSubtractProduct(SubtractProductEvent event, Emitter<OrderState> emit) async {
    if (canChangeOrder) {
      var orderProduct = event.orderProduct.copyWith(quantity: event.orderProduct.quantity - 1);

      _orderRepository.addOrUpdateProduct(orderProduct: orderProduct);
      _analyticsManager.logEvent(SubtractProductAnalyticsEvent(
        productId: orderProduct.product.id,
        productName: orderProduct.product.name,
      ));
    } else {
      emit(state.copyWith(pageStatus: OrderPageStatus.canNotChangeError, toggleState: !state.toggleState));
    }
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<OrderState> emit) async {
    if (canChangeOrder) {
      _orderRepository.deleteProduct(orderProduct: event.orderProduct);

      _analyticsManager.logEvent(DeleteProductAnalyticsEvent(
        productId: event.orderProduct.product.id,
        productName: event.orderProduct.product.name,
      ));
    } else {
      emit(state.copyWith(pageStatus: OrderPageStatus.canNotChangeError, toggleState: !state.toggleState));
    }
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

    _analyticsManager.logEvent(CancelOrderAnalyticsEvent());
  }

  Future<void> _onConfirmOrder(ConfirmOrderEvent event, Emitter<OrderState> emit) async {
    await configureLocalNotifications(date: state.order.date);

    emit(state.copyWith(pageStatus: OrderPageStatus.loading));
    var response = await _orderRepository.confirmOrder();

    if (response) {
      emit(state.copyWith(pageStatus: OrderPageStatus.confirmationOk, canConfirm: false));
    } else {
      emit(state.copyWith(pageStatus: OrderPageStatus.confirmationError));
    }

    _analyticsManager.logEvent(ConfirmOrderAnalyticsEvent(success: response));
  }

  Future<void> configureLocalNotifications({required String date}) async {
    if (await isNotificationsAllowed()) {
      await AwesomeNotifications().cancelAll();

      var orderDate = DateFormat('dd/MM/yyyy').parse(date);
      var endDate = orderDate.add(const Duration(days: 4, hours: 12));

      if (endDate.millisecondsSinceEpoch < DateTime.now().millisecondsSinceEpoch) {
        endDate = endDate.add(const Duration(days: 7));
      }

      unawaited(
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: 'Ecosecha',
            body: '¡Último día para modificar tu pedido!',
            wakeUpScreen: true,
            category: NotificationCategory.Reminder,
            notificationLayout: NotificationLayout.BigText,
            autoDismissible: false,
          ),
          schedule: NotificationCalendar(
            weekday: endDate.weekday,
            hour: endDate.hour,
            allowWhileIdle: true,
            repeats: true,
            preciseAlarm: true,
          ),
        ),
      );
    }
  }

  Future<bool> isNotificationsAllowed() async {
    var isAllowed = await AwesomeNotifications().isNotificationAllowed();

    if (!isAllowed) {
      isAllowed = await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    return isAllowed;
  }
}

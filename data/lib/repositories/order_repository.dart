import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';

// ignore: depend_on_referenced_packages
import "package:rxdart/rxdart.dart";
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;

class OrderRepository {
  OrderRepository({
    required this.apiClient,
    required this.repository,
    required this.authRepository,
    required this.productsRepository,
    required this.userRepository,
  }) {
    _orderInMemory = _getOrderFromApi();
    _orderStreamController.add(_orderInMemory);
  }

  final ApiClient apiClient;
  final Repository repository;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final ProductsRepository productsRepository;

  final _orderStreamController = BehaviorSubject<Order>.seeded(Order.empty);
  Order _orderInMemory = Order.empty;

  Stream<Order> get order => _orderStreamController.asBroadcastStream();
  bool get isCancelled => _getOrderFromApi().products.isEmpty;

  List<Order>? get orderHistory {
    if (repository.orderHistoryDtoList != null) {
      return Mappers.toOrderHistoryList(orderHistoryDtoList: repository.orderHistoryDtoList!);
    }

    return null;
  }

  Future<bool> confirmOrder() async {
    Order orderFromApi = _getOrderFromApi();
    Map<String, dynamic> body;
    var jwt = authRepository.jwt?.value;
    var user = userRepository.user;

    if (jwt != null && user != null) {
      body = {
        "token": jwt,
        "usuario": user.id,
        "fechaPedido": orderFromApi.date,
        "mdoLineasPedidoWeb": mapOrderDtoToJson(),
        "email": "",
        "cuentaCorreo": user.email,
        "htmlPedido": await _getHtmlPedido()
      };

      return apiClient.post(path: 'grabarpedido', body: body).then((response) {
        if (kDebugMode) {
          print(response);
        }

        return Future.value(true);
      });
    } else {
      return Future.value(false);
    }
  }

  List<Map<String, dynamic>> mapOrderDtoToJson() {
    List<Map<String, dynamic>> json = [];
    Order order = _orderInMemory;

    for (var orderProduct in order.products) {
      var product = orderProduct.product;

      json.add({
        "nombreProducto": product.name,
        "cantidad": orderProduct.quantity.toString(),
        "codigoProducto": product.codigo.toString(),
        "familiaProducto": product.family.toString(),
        "importe": orderProduct.amount.toString(),
        "precio": product.price,
        "idProducto": product.id
      });
    }
    
    return json;
  }

  Future<String> _getHtmlPedido() async {
    String htmlPedidoTemplate = await rootBundle.loadString('assets/html_pedido.txt');
    var user = userRepository.user;
    Order orderFromApi = _getOrderFromApi();
    String orderProducts = _getOrderProductsHtml();

    htmlPedidoTemplate = htmlPedidoTemplate.replaceFirst('{{userName}}', user?.name ?? '');
    htmlPedidoTemplate = htmlPedidoTemplate.replaceFirst('{{date}}', orderFromApi.date);
    htmlPedidoTemplate = htmlPedidoTemplate.replaceFirst('{{orderProducts}}', orderProducts);

    return htmlPedidoTemplate;
  }

  String _getOrderProductsHtml() {
    Order order = _orderInMemory;
    String html = '';

    for (var orderProduct in order.products) {
      var product = orderProduct.product;

      html += '<li>${product.name} (${orderProduct.quantity})</li>';
    }

    return html;
  }

  void addOrUpdateProduct({required OrderProduct orderProduct}) {
    int savedOrderProductIndex =
        _orderInMemory.products.indexWhere((element) => element.product == orderProduct.product);

    if (savedOrderProductIndex == -1) {
      _orderInMemory.products.add(orderProduct);
    } else {
      _orderInMemory.products[savedOrderProductIndex] = orderProduct;
    }

    _emitOrderChange();
  }

  void deleteProduct({required OrderProduct orderProduct}) {
    _orderInMemory.products.removeWhere((element) => element.product == orderProduct.product);

    _emitOrderChange();
  }

  Order _getOrderFromApi() {
    if (repository.orderDto != null && repository.userDto != null && repository.productDtoList != null) {
      _removeEmptyMaps();

      return Mappers.toOrder(
        orderDto: repository.orderDto!,
        userDto: repository.userDto!,
        productDtoList: repository.productDtoList!,
      );
    } else {
      return Order.empty;
    }
  }

  // BACKEND API BUG
  void _removeEmptyMaps() {
    repository.orderDto!.products.removeWhere((element) => element.id == 0);
  }

  void _emitOrderChange() {
    _orderStreamController.add(_orderInMemory);
  }
}

import 'package:domain/domain.dart';

class AddProductAnalyticsEvent implements AnalyticsEvent {
  AddProductAnalyticsEvent({required this.productId, required this.productName});

  @override
  String get name => AnalyticsEventName.addProduct;

  late final int productId;
  late final String productName;

  @override
  Map<String, dynamic> get properties => {'productId': productId, 'productName': productName};
}
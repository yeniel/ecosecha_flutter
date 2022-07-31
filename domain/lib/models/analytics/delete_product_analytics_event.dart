import 'package:domain/domain.dart';

class DeleteProductAnalyticsEvent implements AnalyticsEvent {
  DeleteProductAnalyticsEvent({required this.productId, required this.productName});

  @override
  String get name => AnalyticsEventName.deleteProduct;

  late final int productId;
  late final String productName;

  @override
  Map<String, dynamic> get properties => {'productId': productId, 'productName': productName};
}

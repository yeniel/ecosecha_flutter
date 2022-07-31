import 'package:domain/domain.dart';

class SubtractProductAnalyticsEvent implements AnalyticsEvent {
  SubtractProductAnalyticsEvent({required this.productId, required this.productName});

  @override
  String get name => AnalyticsEventName.subtractProduct;

  late final int productId;
  late final String productName;

  @override
  Map<String, dynamic> get properties => {'productId': productId, 'productName': productName};
}
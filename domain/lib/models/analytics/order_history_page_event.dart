import 'package:domain/domain.dart';

class OrderHistoryPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.orderHistoryPage;

  @override
  Map<String, dynamic> get properties => {};
}
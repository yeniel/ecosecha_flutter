import 'package:domain/domain.dart';

class BasketsPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.basketsPage;

  @override
  Map<String, dynamic> get properties => {};
}
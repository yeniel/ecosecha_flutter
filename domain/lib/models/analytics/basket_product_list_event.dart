import 'package:domain/domain.dart';

class BasketProductListPageEvent implements AnalyticsEvent {
  BasketProductListPageEvent({required this.basketId, required this.basketName});

  late final int basketId;
  late final String basketName;

  @override
  String get name => AnalyticsEventName.basketProductListPage;

  @override
  Map<String, dynamic> get properties => {'basketId': basketId, 'basketName': basketName};
}

import 'package:domain/domain.dart';

class CategoryPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.categoryPage;

  late final int categoryId;
  late final String categoryName;

  @override
  Map<String, dynamic> get properties => {'productId': categoryId, 'productName': categoryName};
}
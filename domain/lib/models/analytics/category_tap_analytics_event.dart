import 'package:domain/domain.dart';

class CategoryTapAnalyticsEvent implements AnalyticsEvent {
  CategoryTapAnalyticsEvent({required this.categoryId, required this.categoryName});

  @override
  String get name => AnalyticsEventName.categoryTap;

  late final int categoryId;
  late final String categoryName;

  @override
  Map<String, dynamic> get properties => {'productId': categoryId, 'productName': categoryName};
}
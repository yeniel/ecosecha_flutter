import 'package:domain/domain.dart';

class CategoriesPageEvent implements AnalyticsEvent {
  @override
  String get name => AnalyticsEventName.categoriesPage;

  @override
  Map<String, dynamic> get properties => {};
}
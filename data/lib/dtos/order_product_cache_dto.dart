import 'package:equatable/equatable.dart';

class OrderProductCacheDto extends Equatable {
  const OrderProductCacheDto({required this.id, required this.quantity});

  final int id;
  final int quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [id, quantity];
}
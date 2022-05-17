import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_dto.g.dart';

@JsonSerializable()
class OrderItemDto {
  const OrderItemDto({required this.id, required this.name, required this.price, required this.quantity});

  factory OrderItemDto.fromJson(Map<String, dynamic> json) => _$OrderItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDtoToJson(this);

  @JsonKey(name: 'idProducto', defaultValue: 0)
  final int id;

  @JsonKey(name: 'nombreProducto', defaultValue: '')
  final String name;

  @JsonKey(name: 'cantidad', defaultValue: 0.0)
  final double quantity;

  @JsonKey(name: 'precio', defaultValue: 0.0)
  final double price;

  OrderItem toModel() {
    return OrderItem(id: id, name: name, quantity: quantity.toInt(), price: price);
  }
}
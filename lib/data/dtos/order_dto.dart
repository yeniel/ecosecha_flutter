import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  const OrderDto({required this.items, required this.date, required this.basket});

  factory OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);

  @JsonKey(name: 'articulos')
  final List<OrderItemDto> items;

  @JsonKey(name: 'fecha')
  final String date;

  @JsonKey(name: 'cesta')
  final String basket;

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);

  Order toModel() {
    return Order(items: items.map((e) => e.toModel()).toList(), date: date);
  }
}
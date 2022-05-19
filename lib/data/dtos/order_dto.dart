import 'package:ecosecha_flutter/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  const OrderDto({required this.products, required this.date});

  factory OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);

  @JsonKey(name: 'articulos')
  final List<OrderProductDto> products;

  @JsonKey(name: 'fecha')
  final String date;

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'order_product_dto.g.dart';

@JsonSerializable()
class OrderProductDto {
  const OrderProductDto({required this.id, required this.quantity});

  factory OrderProductDto.fromJson(Map<String, dynamic> json) => _$OrderProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductDtoToJson(this);

  @JsonKey(name: 'idProducto', defaultValue: 0)
  final int id;

  @JsonKey(name: 'cantidad', defaultValue: 0.0)
  final double quantity;
}
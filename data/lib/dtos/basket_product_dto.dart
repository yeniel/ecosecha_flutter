import 'package:json_annotation/json_annotation.dart';

part 'basket_product_dto.g.dart';

@JsonSerializable()
class BasketProductDto {
  BasketProductDto({
    required this.quantity,
    required this.basketId,
    required this.name,
    required this.origin,
  });

  factory BasketProductDto.fromJson(Map<String, dynamic> json) => _$BasketProductDtoFromJson(json);

  @JsonKey(name: 'cantidad')
  final String quantity;

  @JsonKey(name: 'codigoCatalogo')
  final String basketId;

  @JsonKey(name: 'descripcion')
  final String name;

  @JsonKey(name: 'procedencia')
  final String origin;

  Map<String, dynamic> toJson() => _$BasketProductDtoToJson(this);
}

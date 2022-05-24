import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  const ProductDto({
    required this.id,
    required this.basketId,
    required this.name,
    required this.price,
    required this.origin,
    required this.image,
    required this.measureUnit,
    required this.family,
    required this.category,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'codigo')
  final String basketId;

  @JsonKey(name: 'descripcion')
  final String name;

  @JsonKey(name: 'precio')
  final double price;

  @JsonKey(name: 'procedencia')
  final String origin;

  @JsonKey(name: 'rutaImagen')
  final String image;

  @JsonKey(name: 'unidadMedida')
  final String measureUnit;

  @JsonKey(name: 'familia')
  final String family;

  @JsonKey(name: 'categoria')
  final String category;

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}

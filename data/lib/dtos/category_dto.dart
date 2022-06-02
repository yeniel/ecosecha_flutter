import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  const CategoryDto({
    required this.id,
    required this.name,
});

  factory CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);

  @JsonKey(name: 'codigo')
  final int id;

  @JsonKey(name: 'nombre')
  final String name;

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
}
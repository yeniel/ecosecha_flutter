import 'package:ecosecha_flutter/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'family_dto.g.dart';

@JsonSerializable()
class FamilyDto {
  const FamilyDto({
    required this.id,
    required this.name,
    required this.categories,
});

  factory FamilyDto.fromJson(Map<String, dynamic> json) => _$FamilyDtoFromJson(json);

  @JsonKey(name: 'codigo')
  final int id;

  @JsonKey(name: 'nombre')
  final String name;

  @JsonKey(name: 'mdoCategorias')
  final List<CategoryDto> categories;

  Map<String, dynamic> toJson() => _$FamilyDtoToJson(this);
}
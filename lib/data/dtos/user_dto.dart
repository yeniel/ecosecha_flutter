import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  const UserDto({required this.id, required this.name});

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  @JsonKey(name: 'codigo')
  final int id;

  @JsonKey(name: 'nombre')
  final String name;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  User toModel() {
    return User(id: id, name: name);
  }
}
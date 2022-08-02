import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  const UserDto({
    required this.id,
    required this.name,
    required this.emails,
    required this.deliveryGroup,
    required this.orderWarning,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  @JsonKey(name: 'codigo')
  final int id;

  @JsonKey(name: 'nombre')
  final String name;

  @JsonKey(name: 'cuentasCorreo')
  final List<String> emails;

  @JsonKey(name: 'nombreGrupo')
  final String deliveryGroup;

  @JsonKey(name: 'validacion')
  final String orderWarning;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

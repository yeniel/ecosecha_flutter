import 'package:json_annotation/json_annotation.dart';

part 'jwt_dto.g.dart';

@JsonSerializable()
class JwtDto {
  const JwtDto({required this.value});

  factory JwtDto.fromJson(Map<String, dynamic> json) => _$JwtDtoFromJson(json);

  @JsonKey(name: 'JWT')
  final String value;

  Map<String, dynamic> toJson() => _$JwtDtoToJson(this);
}
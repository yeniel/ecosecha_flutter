// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['codigo'] as int,
      name: json['nombre'] as String,
      emails: (json['cuentasCorreo'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      deliveryGroup: json['nombreGrupo'] as String,
      warningMessage: json['validacion'] as String,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'codigo': instance.id,
      'nombre': instance.name,
      'cuentasCorreo': instance.emails,
      'nombreGrupo': instance.deliveryGroup,
      'validacion': instance.warningMessage,
    };

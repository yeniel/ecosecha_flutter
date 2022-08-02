// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyDto _$FamilyDtoFromJson(Map<String, dynamic> json) => FamilyDto(
      id: json['codigo'] as int,
      name: json['nombre'] as String,
      categories: (json['mdoCategorias'] as List<dynamic>)
          .map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FamilyDtoToJson(FamilyDto instance) => <String, dynamic>{
      'codigo': instance.id,
      'nombre': instance.name,
      'mdoCategorias': instance.categories,
    };

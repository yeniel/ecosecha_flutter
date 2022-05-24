// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => ProductDto(
      id: json['id'] as int,
      basketId: json['codigo'] as String,
      name: json['descripcion'] as String,
      price: (json['precio'] as num).toDouble(),
      origin: json['procedencia'] as String,
      image: json['rutaImagen'] as String,
      measureUnit: json['unidadMedida'] as String,
      family: json['familia'] as String,
      category: json['categoria'] as String,
    );

Map<String, dynamic> _$ProductDtoToJson(ProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'codigo': instance.basketId,
      'descripcion': instance.name,
      'precio': instance.price,
      'procedencia': instance.origin,
      'rutaImagen': instance.image,
      'unidadMedida': instance.measureUnit,
      'familia': instance.family,
      'categoria': instance.category,
    };

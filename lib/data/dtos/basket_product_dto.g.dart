// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketProductDto _$BasketProductDtoFromJson(Map<String, dynamic> json) =>
    BasketProductDto(
      quantity: json['cantidad'] as String,
      basketId: json['codigoCatalogo'] as String,
      name: json['descripcion'] as String,
      origin: json['procedencia'] as String,
    );

Map<String, dynamic> _$BasketProductDtoToJson(BasketProductDto instance) =>
    <String, dynamic>{
      'cantidad': instance.quantity,
      'codigoCatalogo': instance.basketId,
      'descripcion': instance.name,
      'procedencia': instance.origin,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductDto _$OrderProductDtoFromJson(Map<String, dynamic> json) =>
    OrderProductDto(
      id: json['idProducto'] as int? ?? 0,
      quantity: (json['cantidad'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$OrderProductDtoToJson(OrderProductDto instance) =>
    <String, dynamic>{
      'idProducto': instance.id,
      'cantidad': instance.quantity,
    };

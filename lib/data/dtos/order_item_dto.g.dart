// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemDto _$OrderItemDtoFromJson(Map<String, dynamic> json) => OrderItemDto(
      id: json['idProducto'] as int? ?? 0,
      name: json['nombreProducto'] as String? ?? '',
      price: (json['precio'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['cantidad'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$OrderItemDtoToJson(OrderItemDto instance) =>
    <String, dynamic>{
      'idProducto': instance.id,
      'nombreProducto': instance.name,
      'cantidad': instance.quantity,
      'precio': instance.price,
    };

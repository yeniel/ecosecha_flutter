// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => OrderDto(
      products: (json['articulos'] as List<dynamic>)
          .map((e) => OrderProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: json['fecha'] as String,
    );

Map<String, dynamic> _$OrderDtoToJson(OrderDto instance) => <String, dynamic>{
      'articulos': instance.products,
      'fecha': instance.date,
    };

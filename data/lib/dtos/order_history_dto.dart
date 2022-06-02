import 'package:json_annotation/json_annotation.dart';

part 'order_history_dto.g.dart';

@JsonSerializable()
class OrderHistoryDto {
  const OrderHistoryDto({required this.date});

  factory OrderHistoryDto.fromJson(Map<String, dynamic> json) => _$OrderHistoryDtoFromJson(json);

  @JsonKey(name: 'fecha')
  final String date;

  Map<String, dynamic> toJson() => _$OrderHistoryDtoToJson(this);
}
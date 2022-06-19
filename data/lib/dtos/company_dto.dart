import 'package:json_annotation/json_annotation.dart';

part 'company_dto.g.dart';

@JsonSerializable()
class CompanyDto {
  const CompanyDto({
    required this.blogUrl,
    required this.cif,
    required this.email,
    required this.address,
    required this.town,
    required this.zip,
    required this.province,
    required this.name,
    required this.phone,
    required this.webUrl,
    required this.minimumAmount,
  });

  factory CompanyDto.fromJson(Map<String, dynamic> json) => _$CompanyDtoFromJson(json);

  @JsonKey(name: 'blog', defaultValue: '')
  final String blogUrl;

  @JsonKey(name: 'cifEmpresa', defaultValue: '')
  final String cif;

  @JsonKey(name: 'cuentaCorreo', defaultValue: '')
  final String email;

  @JsonKey(name: 'direccionEmpresa', defaultValue: '')
  final String address;

  @JsonKey(name: 'poblacionEmpresa', defaultValue: '')
  final String town;

  @JsonKey(name: 'postalEmpresa', defaultValue: '')
  final String zip;

  @JsonKey(name: 'provinciaEmpresa', defaultValue: '')
  final String province;

  @JsonKey(name: 'nombreEmpresa', defaultValue: '')
  final String name;

  @JsonKey(name: 'telefonoEmpresa', defaultValue: '')
  final String phone;

  @JsonKey(name: 'web', defaultValue: '')
  final String webUrl;

  @JsonKey(name: 'importeMinimo', defaultValue: '0')
  final String minimumAmount;

  Map<String, dynamic> toJson() => _$CompanyDtoToJson(this);
}

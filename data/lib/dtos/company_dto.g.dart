// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDto _$CompanyDtoFromJson(Map<String, dynamic> json) => CompanyDto(
      blogUrl: json['blog'] as String? ?? '',
      cif: json['cifEmpresa'] as String? ?? '',
      email: json['cuentaCorreo'] as String? ?? '',
      address: json['direccionEmpresa'] as String? ?? '',
      town: json['poblacionEmpresa'] as String? ?? '',
      zip: json['postalEmpresa'] as String? ?? '',
      province: json['provinciaEmpresa'] as String? ?? '',
      name: json['nombreEmpresa'] as String? ?? '',
      phone: json['telefonoEmpresa'] as String? ?? '',
      webUrl: json['web'] as String? ?? '',
      minimumAmount: json['importeMinimo'] as String? ?? '0',
    );

Map<String, dynamic> _$CompanyDtoToJson(CompanyDto instance) =>
    <String, dynamic>{
      'blog': instance.blogUrl,
      'cifEmpresa': instance.cif,
      'cuentaCorreo': instance.email,
      'direccionEmpresa': instance.address,
      'poblacionEmpresa': instance.town,
      'postalEmpresa': instance.zip,
      'provinciaEmpresa': instance.province,
      'nombreEmpresa': instance.name,
      'telefonoEmpresa': instance.phone,
      'web': instance.webUrl,
      'importeMinimo': instance.minimumAmount,
    };

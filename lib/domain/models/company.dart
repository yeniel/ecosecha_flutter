import 'package:equatable/equatable.dart';

class Company extends Equatable {
  const Company({this.blogUrl, this.cif, this.email, this.address, this.name, this.phone, this.webUrl});

  final String? blogUrl;
  final String? cif;
  final String? email;
  final String? address;
  final String? name;
  final String? phone;
  final String? webUrl;

  static const empty = Company();

  @override
  List<Object> get props => [];
}
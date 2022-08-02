import 'package:equatable/equatable.dart';

class Company extends Equatable {
  const Company({
    required this.blogUrl,
    required this.cif,
    required this.email,
    required this.address,
    required this.name,
    required this.phone,
    required this.ordersWebUrl,
    required this.minimumAmount,
  });

  final String blogUrl;
  final String cif;
  final String email;
  final String address;
  final String name;
  final String phone;
  final String ordersWebUrl;
  final int minimumAmount;

  static const empty = Company(
    blogUrl: '',
    cif: '',
    email: '',
    address: '',
    name: '',
    phone: '',
    ordersWebUrl: '',
    minimumAmount: 0,
  );

  @override
  List<Object> get props => [];
}

import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, this.name, this.email, required this.deliveryGroup});

  final int id;
  final String? name;
  final String? email;
  final String deliveryGroup;

  static const empty = User(id: 0, deliveryGroup: '');

  @override
  List<Object> get props => [id];
}
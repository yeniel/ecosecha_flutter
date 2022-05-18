import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, this.name, this.email});

  final int id;
  final String? name;
  final String? email;

  static const empty = User(id: 0);

  @override
  List<Object> get props => [id];
}
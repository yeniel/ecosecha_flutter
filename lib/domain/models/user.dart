import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, this.name});

  final int id;
  final String? name;

  @override
  List<Object> get props => [id];

  static const empty = User(id: 0);
}
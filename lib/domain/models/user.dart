import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, this.name});

  final int id;
  final String? name;

  static const empty = User(id: 0);

  @override
  List<Object> get props => [id];
}
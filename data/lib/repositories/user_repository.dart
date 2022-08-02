import 'package:data/data.dart';
import 'package:domain/domain.dart';

class UserRepository {
  const UserRepository({required this.repository});

  final Repository repository;

  User? get user => Mappers.toUser(userDto: repository.userDto);
}
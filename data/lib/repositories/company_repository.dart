import 'package:data/data.dart';
import 'package:domain/domain.dart';

class CompanyRepository {
  const CompanyRepository({required this.repository});

  final Repository repository;

  Company? get company => Mappers.toCompany(companyDto: repository.companyDto);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/data.dart' as _i3;
import 'data/repositories/auth/auth_service.dart' as _i5;
import 'data/repositories/http_api_client.dart' as _i4;
import 'data/repositories/repository.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ApiClient>(() => _i4.HttpApiClient());
  gh.factory<_i5.AuthService>(
      () => _i5.AuthService(apiClient: get<_i3.ApiClient>()));
  gh.factory<_i6.Repository>(() => _i6.Repository(
      apiClient: get<_i3.ApiClient>(), authService: get<_i5.AuthService>()));
  return get;
}

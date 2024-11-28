// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../router/router.dart' as _i3;
import '../../data/data.dart' as _i4;
import '../../data/datasources/remote/schedule_data_source.dart' as _i5;
import '../../data/repositories/schedule_repository_impl.dart' as _i7;
import '../../domain/domain.dart' as _i6;
import '../../presentation/blocs/employees/employees_cubit.dart' as _i8;
import '../../presentation/blocs/groups/groups_cubit.dart' as _i9;
import 'register_module.dart' as _i10;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
  gh.lazySingleton<_i4.ScheduleApiService>(
      () => registerModule.getScheduleApiService());
  gh.lazySingleton<_i5.ScheduleDataSource>(
      () => _i5.ScheduleDataSource(gh<_i4.ScheduleApiService>()));
  gh.lazySingleton<_i6.ScheduleRepository>(
      () => _i7.ScheduleRepositoryImpl(gh<_i4.ScheduleDataSource>()));
  gh.factory<_i8.EmployeesCubit>(
      () => _i8.EmployeesCubit(gh<_i6.ScheduleRepository>()));
  gh.factory<_i9.GroupsCubit>(
      () => _i9.GroupsCubit(gh<_i6.ScheduleRepository>()));
  return getIt;
}

class _$RegisterModule extends _i10.RegisterModule {}

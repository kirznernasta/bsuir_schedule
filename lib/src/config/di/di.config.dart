// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../../../router/router.dart' as _i3;
import '../../data/data.dart' as _i4;
import '../../data/datasources/local/app_settings_local_data_source.dart'
    as _i9;
import '../../data/datasources/remote/schedule_data_source.dart' as _i5;
import '../../data/repositories/application_repository_impl.dart' as _i10;
import '../../data/repositories/favourites_repository_impl.dart' as _i12;
import '../../data/repositories/schedule_repository_impl.dart' as _i7;
import '../../domain/domain.dart' as _i6;
import '../../presentation/blocs/employees/employees_cubit.dart' as _i11;
import '../../presentation/blocs/favourites/employees/favourite_employees_cubit.dart'
    as _i16;
import '../../presentation/blocs/favourites/groups/favourite_groups_cubit.dart'
    as _i17;
import '../../presentation/blocs/groups/groups_cubit.dart' as _i13;
import '../../presentation/blocs/schedule/schedule_cubit.dart' as _i14;
import '../../presentation/blocs/user/user_cubit.dart' as _i15;
import 'register_module.dart' as _i18;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
  await gh.lazySingletonAsync<_i4.ScheduleApiService>(
    () => registerModule.getScheduleApiService(),
    preResolve: true,
  );
  gh.lazySingleton<_i5.ScheduleDataSource>(
      () => _i5.ScheduleDataSource(gh<_i4.ScheduleApiService>()));
  gh.lazySingleton<_i6.ScheduleRepository>(
      () => _i7.ScheduleRepositoryImpl(gh<_i4.ScheduleDataSource>()));
  await gh.lazySingletonAsync<_i8.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i9.AppSettingsLocalDataSource>(() =>
      _i9.AppSettingsLocalDataSource(gh<_i8.SharedPreferences>())..init());
  gh.lazySingleton<_i6.ApplicationRepository>(
      () => _i10.ApplicationRepositoryImpl(
            gh<_i4.ScheduleDataSource>(),
            gh<_i4.AppSettingsLocalDataSource>(),
          ));
  gh.factory<_i11.EmployeesCubit>(
      () => _i11.EmployeesCubit(gh<_i6.ScheduleRepository>()));
  gh.lazySingleton<_i6.FavouritesRepository>(
      () => _i12.FavouritesRepositoryImpl(
            gh<_i4.ScheduleDataSource>(),
            gh<_i4.AppSettingsLocalDataSource>(),
          ));
  gh.factory<_i13.GroupsCubit>(
      () => _i13.GroupsCubit(gh<_i6.ScheduleRepository>()));
  gh.factory<_i14.ScheduleCubit>(
      () => _i14.ScheduleCubit(gh<_i6.ScheduleRepository>()));
  gh.lazySingleton<_i15.UserCubit>(
      () => _i15.UserCubit(gh<_i6.ApplicationRepository>()));
  gh.lazySingleton<_i16.FavouriteEmployeesCubit>(
      () => _i16.FavouriteEmployeesCubit(gh<_i6.FavouritesRepository>()));
  gh.lazySingleton<_i17.FavouriteGroupsCubit>(
      () => _i17.FavouriteGroupsCubit(gh<_i6.FavouritesRepository>()));
  return getIt;
}

class _$RegisterModule extends _i18.RegisterModule {}

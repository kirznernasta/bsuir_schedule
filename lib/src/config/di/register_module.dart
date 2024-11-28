import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  ScheduleApiService getScheduleApiService() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://iis.bsuir.by/api/v1/',
        queryParameters: {'format': 'json'},
      ),
    );

    return ScheduleApiService(dio);
  }
}

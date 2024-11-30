import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/domain.dart';

part './schedule_state.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepository _scheduleRepository;

  ScheduleCubit(this._scheduleRepository) : super(ScheduleInitial());

  Future<void> fetchSchedule({
    required bool isGroup,
    required String searchingInput,
  }) async {
    emit(ScheduleInProgress());

    late final ScheduleEntity? schedule;
    if (isGroup) {
      schedule = await _scheduleRepository.fetchGroupSchedule(searchingInput);
    } else {
      schedule = await _scheduleRepository.fetchEmployeeSchedule(searchingInput);
    }

    if (isClosed) return;

    emit(ScheduleUpdate(schedule: schedule));
  }
}

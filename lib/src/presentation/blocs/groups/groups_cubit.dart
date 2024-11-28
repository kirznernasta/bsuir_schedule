import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/domain.dart';

part './groups_state.dart';

@injectable
class GroupsCubit extends Cubit<GroupsState> {
  final ScheduleRepository _scheduleRepository;

  var _groups = <StudentGroupEntity>[];

  GroupsCubit(this._scheduleRepository) : super(GroupsInitial());

  Future<void> fetchAllGroups() async {
    emit(GroupsInProgress());

    final groups = await _scheduleRepository.fetchAllGroups()
      ..sort((a, b) => a.name.compareTo(b.name));

    _groups = groups;

    if (isClosed) return;

    emit(GroupsUpdate(groups: groups));
  }

  void filterByGroupNumber(String searchInput) {
    final groups = _groups.where((group) => group.name.startsWith(searchInput));

    emit(GroupsUpdate(groups: groups.toList()));
  }
}

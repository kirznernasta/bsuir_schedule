part of './../schedule_screen.dart';

class _DaySchedule extends StatelessWidget {
  final DateTime date;
  final int weekNumber;
  final SubgroupType subgroupFilter;
  final bool isGroupSchedule;
  final List<ScheduleItemEntity>? items;

  const _DaySchedule({
    required this.date,
    required this.weekNumber,
    required this.subgroupFilter,
    required this.isGroupSchedule,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    final schedule = items?.where(
      (e) => e.weekNumbers.contains(weekNumber) && e.lessonType.isRegularType,
    );

    if (schedule == null || schedule.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${DateFormat('EEE, MMM d').format(date)}, Week $weekNumber'),
        for (final item in schedule) ...[
          _ScheduleWeekItem(
            item: item,
            isHidden: subgroupFilter.number > 0 &&
                item.subgroupNumber > 0 &&
                item.subgroupNumber != subgroupFilter.number,
            isWeekVisible: false,
            isGroupSchedule: isGroupSchedule,
          ),
          SizedBox(height: 8.h),
        ],
        SizedBox(height: 24.h),
      ],
    );
  }
}

part of './../schedule_screen.dart';

class _WeekSchedule extends StatelessWidget {
  final bool isGroupSchedule;
  final ScheduleEntity schedule;
  final SubgroupType subgroupFilter;

  const _WeekSchedule({
    required this.schedule,
    required this.subgroupFilter,
    required this.isGroupSchedule,
  });

  @override
  Widget build(BuildContext context) {
    final weekSchedule = schedule.schedules;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text('Classes: ${schedule.startDate}-${schedule.endDate}'),
        SizedBox(height: 16.h),
        Expanded(
          child: ListView(
            children: [
              if (weekSchedule!.monday != null) ...[
                Text('Monday'),
                for (final item in weekSchedule.monday!
                    .where((e) => e.lessonType.isRegularType)) ...[
                  _ScheduleWeekItem(
                    item: item,
                    isWeekVisible: true,
                    isGroupSchedule: isGroupSchedule,
                    isHidden: subgroupFilter.number > 0 &&
                        item.subgroupNumber > 0 &&
                        item.subgroupNumber != subgroupFilter.number,
                  ),
                  SizedBox(height: 8.h),
                ],
                SizedBox(height: 24.h),
              ],
              if (weekSchedule.tuesday != null) ...[
                Text('Tuesday'),
                for (final item in weekSchedule.tuesday!
                    .where((e) => e.lessonType.isRegularType)) ...[
                  _ScheduleWeekItem(
                    item: item,
                    isWeekVisible: true,
                    isGroupSchedule: isGroupSchedule,
                    isHidden: subgroupFilter.number > 0 &&
                        item.subgroupNumber > 0 &&
                        item.subgroupNumber != subgroupFilter.number,
                  ),
                  SizedBox(height: 8.h),
                ],
                SizedBox(height: 24.h),
              ],
              if (weekSchedule.wednesday != null) ...[
                Text('Wednesday'),
                for (final item in weekSchedule.wednesday!
                    .where((e) => e.lessonType.isRegularType)) ...[
                  _ScheduleWeekItem(
                    item: item,
                    isWeekVisible: true,
                    isGroupSchedule: isGroupSchedule,
                    isHidden: subgroupFilter.number > 0 &&
                        item.subgroupNumber > 0 &&
                        item.subgroupNumber != subgroupFilter.number,
                  ),
                  SizedBox(height: 8.h),
                ],
                SizedBox(height: 24.h),
              ],
              if (weekSchedule.thursday != null) ...[
                Text('Thursday'),
                for (final item in weekSchedule.thursday!
                    .where((e) => e.lessonType.isRegularType)) ...[
                  _ScheduleWeekItem(
                    item: item,
                    isWeekVisible: true,
                    isGroupSchedule: isGroupSchedule,
                    isHidden: subgroupFilter.number > 0 &&
                        item.subgroupNumber > 0 &&
                        item.subgroupNumber != subgroupFilter.number,
                  ),
                  SizedBox(height: 8.h),
                ],
                SizedBox(height: 24.h),
              ],
              if (weekSchedule.friday != null) ...[
                Text('Friday'),
                for (final item in weekSchedule.friday!
                    .where((e) => e.lessonType.isRegularType)) ...[
                  _ScheduleWeekItem(
                    item: item,
                    isWeekVisible: true,
                    isGroupSchedule: isGroupSchedule,
                    isHidden: subgroupFilter.number > 0 &&
                        item.subgroupNumber > 0 &&
                        item.subgroupNumber != subgroupFilter.number,
                  ),
                  SizedBox(height: 8.h),
                ],
                SizedBox(height: 24.h),
              ],
              if (weekSchedule.saturday != null) ...[
                Text('Saturday'),
                for (final item in weekSchedule.saturday!
                    .where((e) => e.lessonType.isRegularType)) ...[
                  _ScheduleWeekItem(
                    item: item,
                    isWeekVisible: true,
                    isGroupSchedule: isGroupSchedule,
                    isHidden: subgroupFilter.number > 0 &&
                        item.subgroupNumber > 0 &&
                        item.subgroupNumber != subgroupFilter.number,
                  ),
                  SizedBox(height: 8.h),
                ],
                SizedBox(height: 24.h),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

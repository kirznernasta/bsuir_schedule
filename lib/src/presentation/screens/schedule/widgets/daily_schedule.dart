part of './../schedule_screen.dart';

class _DailySchedule extends StatelessWidget {
  final bool isGroupSchedule;
  final ScheduleEntity schedule;
  final SubgroupType subgroupFilter;

  const _DailySchedule({
    required this.schedule,
    required this.subgroupFilter,
    required this.isGroupSchedule,
  });

  @override
  Widget build(BuildContext context) {
    if (schedule.endDate == null) {
      return const Center(child: Text('No schedule!'));
    }

    final currentDate = DateTime.now().toLocal();
    final currentWeek = calculateWeekNumber(
      DateTime(2024, 9).difference(currentDate).inDays,
      1,
      DateTime(2024, 9).weekday,
    );
    final weekSchedule = schedule.schedules;
    final daysLeft =
        DateTime.parse(schedule.endDate?.split('.').reversed.join('-') ?? '')
                .difference(currentDate)
                .inDays +
            2;
    final currentWeekDay = currentDate.weekday;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Expanded(
          child: ListView(
            children: [
              for (var day = 0; day < daysLeft; day++) ...[
                switch (currentDate.add(Duration(days: day)).weekday) {
                  1 => _DaySchedule(
                      date: currentDate.add(Duration(days: day)),
                      weekNumber: calculateWeekNumber(
                        day,
                        currentWeek,
                        currentWeekDay,
                      ),
                      items: weekSchedule!.monday,
                      subgroupFilter: subgroupFilter,
                      isGroupSchedule: isGroupSchedule,
                    ),
                  2 => _DaySchedule(
                      date: currentDate.add(Duration(days: day)),
                      weekNumber: calculateWeekNumber(
                        day,
                        currentWeek,
                        currentWeekDay,
                      ),
                      subgroupFilter: subgroupFilter,
                      items: weekSchedule!.tuesday,
                      isGroupSchedule: isGroupSchedule,
                    ),
                  3 => _DaySchedule(
                      date: currentDate.add(Duration(days: day)),
                      weekNumber: calculateWeekNumber(
                        day,
                        currentWeek,
                        currentWeekDay,
                      ),
                      subgroupFilter: subgroupFilter,
                      items: weekSchedule!.wednesday,
                      isGroupSchedule: isGroupSchedule,
                    ),
                  4 => _DaySchedule(
                      date: currentDate.add(Duration(days: day)),
                      weekNumber: calculateWeekNumber(
                        day,
                        currentWeek,
                        currentWeekDay,
                      ),
                      subgroupFilter: subgroupFilter,
                      items: weekSchedule!.thursday,
                      isGroupSchedule: isGroupSchedule,
                    ),
                  5 => _DaySchedule(
                      date: currentDate.add(Duration(days: day)),
                      weekNumber: calculateWeekNumber(
                        day,
                        currentWeek,
                        currentWeekDay,
                      ),
                      subgroupFilter: subgroupFilter,
                      items: weekSchedule!.friday,
                      isGroupSchedule: isGroupSchedule,
                    ),
                  6 => _DaySchedule(
                      date: currentDate.add(Duration(days: day)),
                      weekNumber: calculateWeekNumber(
                        day,
                        currentWeek,
                        currentWeekDay,
                      ),
                      subgroupFilter: subgroupFilter,
                      items: weekSchedule!.saturday,
                      isGroupSchedule: isGroupSchedule,
                    ),
                  _ => const SizedBox.shrink(),
                },
              ],
            ],
          ),
        ),
      ],
    );
  }

  int calculateWeekNumber(
    int additionalDaysCount,
    int currentWeek,
    int currentDayOfWeek,
  ) {
    const int weeksInCycle = 4;
    const int daysInWeek = 7;

    final weekOffset =
        (currentDayOfWeek - 1 + additionalDaysCount) ~/ daysInWeek;
    final newWeekNumber = (currentWeek - 1 + weekOffset) % weeksInCycle + 1;

    return newWeekNumber;
  }
}

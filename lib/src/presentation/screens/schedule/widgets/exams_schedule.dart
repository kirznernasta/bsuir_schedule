part of './../schedule_screen.dart';

class _ExamsSchedule extends StatelessWidget {
  final bool isGroupSchedule;
  final ScheduleEntity schedule;

  const _ExamsSchedule({required this.schedule, required this.isGroupSchedule});

  @override
  Widget build(BuildContext context) {
    final exams = (schedule.exams)
      ?..sort(
        (a, b) => DateFormat('dd.MM.yyyy').parse(a.lessonDate ?? '').compareTo(
              DateFormat('dd.MM.yyyy').parse(b.lessonDate ?? ''),
            ),
      );

    if (exams == null) {
      return const Column(
        children: [
          Text('No exams!'),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        if (schedule.startExamsDate != null &&
            schedule.endExamsDate != null) ...[
          Text('Exams: ${schedule.startExamsDate}-${schedule.endExamsDate}'),
          SizedBox(height: 16.h),
        ],
        Expanded(
          child: ListView(
            children: [
              for (final item in exams) ...[
                if (item.lessonDate != null) ...[
                  Text(
                    DateFormat('EEE, MMM d').format(
                      DateFormat('dd.MM.yyyy').parse(item.lessonDate!),
                    ),
                    style: context.theme.textTheme.labelLarge,
                  ),
                  SizedBox(height: 16.h),
                ],
                _ScheduleWeekItem(
                  item: item,
                  isWeekVisible: false,
                  isGroupSchedule: isGroupSchedule,
                ),
                SizedBox(height: 24.h),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

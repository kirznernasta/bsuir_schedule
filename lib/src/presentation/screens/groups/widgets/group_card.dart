part of './../groups_screen.dart';

class _GroupCard extends StatelessWidget {
  final bool isFavourite;
  final bool hasCodeText;
  final bool hasTopRounded;
  final bool hasBottomRounded;
  final StudentGroupEntity group;

  const _GroupCard({
    required this.group,
    required this.isFavourite,
    required this.hasTopRounded,
    required this.hasBottomRounded,
    this.hasCodeText = true,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;
    final descriptionTexts = [
      group.facultyAbbrev,
      group.specialityAbbrev,
      if (group.course != null) 'Course ${group.course}',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasTopRounded && hasCodeText)
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
            child: Text(
              group.name.substring(0, 3),
              style: textTheme.titleSmall?.copyWith(
                color: Colors.black38,
              ),
            ),
          ),
        AppCard(
          title: group.name,
          subtitle: descriptionTexts.join('·'),
          hasTopRounded: hasTopRounded,
          hasBottomRounded: hasBottomRounded,
          onTap: () => context.pushRoute(
            ScheduleRoute(
              id: group.id ?? 0,
              isGroupSchedule: true,
              isFavourite: isFavourite,
              searchingInput: group.name,
            ),
          ),
        ),
      ],
    );
  }
}

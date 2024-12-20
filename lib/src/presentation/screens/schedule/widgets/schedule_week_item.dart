part of './../schedule_screen.dart';

class _ScheduleWeekItem extends StatelessWidget {
  final bool isHidden;
  final bool isWeekVisible;
  final bool isGroupSchedule;
  final ScheduleItemEntity item;

  const _ScheduleWeekItem({
    required this.item,
    required this.isWeekVisible,
    required this.isGroupSchedule,
    this.isHidden = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          useSafeArea: true,
          showDragHandle: true,
          context: context,
          backgroundColor: const Color(0xFFEDEDED),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.subjectAbbreviationName,
                    style: textTheme.labelLarge,
                  ),
                  SizedBox(height: 16.h),
                  if (isGroupSchedule) ...[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Employees',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    for (var i = 0; i < (item.employees?.length ?? 0); i++) ...[
                      AppCard(
                        hasTopRounded: i == 0,
                        suffix: ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: Image.network(
                            item.employees?[i].imageUrl ?? '',
                            width: 48.w,
                            height: 48.w,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Assets.icons.placeholder.image(
                              width: 48.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: [
                          item.employees?[i].lastName,
                          item.employees?[i].firstName,
                          if (item.employees?[i].middleName != null)
                            item.employees?[i].middleName,
                        ].join(' '),
                        hasBottomRounded: i == item.studentGroups.length - 1,
                      ),
                      if (i < item.studentGroups.length - 1)
                        Divider(height: 1.h, thickness: 1.h),
                    ],
                  ] else ...[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Groups',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    for (var i = 0; i < item.studentGroups.length; i++) ...[
                      AppCard(
                        hasTopRounded: i == 0,
                        title: item.studentGroups[i].name,
                        hasBottomRounded: i == item.studentGroups.length - 1,
                      ),
                      if (i < item.studentGroups.length - 1)
                        Divider(height: 1.h, thickness: 1.h),
                    ],
                  ],
                  SizedBox(height: 16.h),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Details',
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: 8.r.toBorderRadius(isTopRounded: true),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.subjectFullName,
                                maxLines: 1,
                                style: context.theme.textTheme.labelLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: 8.r.toBorderRadius(),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                maxLines: 1,
                                style: context.theme.textTheme.labelLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${item.startLessonTime}-${item.endLessonTime}',
                          maxLines: 1,
                          style: context.theme.textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: 8.r.toBorderRadius(),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type',
                                maxLines: 1,
                                style: context.theme.textTheme.labelLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          item.lessonType.name,
                          maxLines: 1,
                          style: context.theme.textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: 8.r.toBorderRadius(),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Subgroup',
                                maxLines: 1,
                                style: context.theme.textTheme.labelLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${item.subgroupNumber == 0 ? '--' : item.subgroupNumber}',
                          maxLines: 1,
                          style: context.theme.textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: 8.r.toBorderRadius(),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Auditory',
                                maxLines: 1,
                                style: context.theme.textTheme.labelLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          item.auditories.join(','),
                          maxLines: 1,
                          style: context.theme.textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: 8.r.toBorderRadius(isBottomRounded: true),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weeks',
                                maxLines: 1,
                                style: context.theme.textTheme.labelLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          item.weekNumbers.join(','),
                          maxLines: 1,
                          style: context.theme.textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 48.h),
                ],
              ),
            );
          },
        );
      },
      child: DottedBorder(
        color: isHidden ? Colors.grey : Colors.transparent,
        borderType: BorderType.RRect,
        radius: Radius.circular(8.r),
        child: Container(
          decoration: BoxDecoration(
            color: isHidden ? null : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: isHidden ? 4.h : 8.h,
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    item.startLessonTime,
                    style: isHidden ? textTheme.bodySmall : null,
                  ),
                  Text(
                    item.endLessonTime,
                    style: isHidden ? textTheme.bodySmall : null,
                  ),
                ],
              ),
              SizedBox(width: 8.w),
              Container(
                decoration: BoxDecoration(
                  color: item.lessonType.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: isHidden ? 2.w : 6.w,
                height: isHidden ? 24.h : 32.h,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(item.subjectAbbreviationName),
                      if (isWeekVisible) ...[
                        SizedBox(width: 4.w),
                        Assets.icons.calendar.svg(
                          width: 16.w,
                          colorFilter: const Color(0xff3333333).colorFilter,
                        ),
                        SizedBox(width: 4.w),
                        Text(item.weekNumbers.join(',')),
                      ],
                      SizedBox(width: 4.w),
                      if (item.subgroupNumber > 0) ...[
                        Assets.icons.person.svg(
                          width: 16.w,
                          colorFilter: const Color(0xff3333333).colorFilter,
                        ),
                        Text(
                          item.subgroupNumber.toString(),
                        ),
                      ],
                    ],
                  ),
                  if (!isHidden) Text(item.auditories.join(',')),
                ],
              ),
              const Spacer(),
              if (!isWeekVisible && !isHidden) ...[
                if (isGroupSchedule)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Image.network(
                      width: 48.w,
                      height: 48.w,
                      item.employees?.firstOrNull?.imageUrl ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Assets.icons.placeholder.image(
                        width: 48.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEDED),
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        padding: EdgeInsets.all(8.r),
                        child: Center(
                          child: Text(
                            item.studentGroups.first.name,
                            style: context.theme.textTheme.labelLarge?.copyWith(
                              height: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      if (item.studentGroups.length > 1)
                        Container(
                          width: 18.w,
                          height: 18.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDEDED),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(color: const Color(0xff646464)),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 9,
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

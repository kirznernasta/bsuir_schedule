import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation.dart';

class _Group {
  final String name;
  final String facultyAbbrev;
  final String specialityAbbrev;
  final int? course;

  const _Group({
    required this.name,
    required this.facultyAbbrev,
    required this.specialityAbbrev,
    this.course,
  });
}

@RoutePage()
class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      const _Group(
        name: '050541',
        facultyAbbrev: 'ФКСиС',
        specialityAbbrev: 'ВМСиС',
        course: 5,
      ),
      const _Group(
        name: '063041',
        facultyAbbrev: 'ФИБ',
        specialityAbbrev: 'ИКС(СИ)',
        course: 5,
      ),
      const _Group(
        name: '063042',
        facultyAbbrev: 'ФИБ',
        specialityAbbrev: 'ИКС(СИ)',
        course: 5,
      ),
      const _Group(
        name: '074041',
        facultyAbbrev: 'ИЭФ',
        specialityAbbrev: 'ЭМ',
        course: 5,
      ),
      const _Group(
        name: '1100101',
        facultyAbbrev: 'ФКП',
        specialityAbbrev: 'ИСиТ(с ОПБ)',
        course: 4,
      ),
    ];
    final textTheme = context.theme.textTheme;

    return ScreenTemplate(
      body: Column(
        children: [
          Text('All groups', style: textTheme.headlineMedium),
          SizedBox(height: 24.h),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, i) {
                final isFirst = i == 0;
                final isLast = i == groups.length - 1;
                final group = groups[i];
                var hasTopRounded = isFirst;
                var hasBottomRounded = isLast;
                final currentCode = group.name.substring(0, 3);

                if (i > 0) {
                  final previousGroup = groups[i - 1];
                  final previousCode = previousGroup.name.substring(0, 3);
                  hasTopRounded |= previousCode != currentCode;
                }
                if (i < groups.length - 1) {
                  final nextGroup = groups[i + 1];
                  final nextCode = nextGroup.name.substring(0, 3);
                  hasBottomRounded |= nextCode != currentCode;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasTopRounded)
                      Padding(
                        padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
                        child: Text(
                          currentCode,
                          style: textTheme.titleSmall?.copyWith(
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: 8.r.toBorderRadius(
                                isTopRounded: hasTopRounded,
                                isBottomRounded: hasBottomRounded,
                              ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(group.name),
                                Text(
                                  '${group.facultyAbbrev} ${group.specialityAbbrev}',
                                  style: textTheme.labelSmall?.copyWith(
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16.w,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (_, i) {
                final group = groups[i];

                return SizedBox(
                  height: group.name.substring(0, 3) !=
                          groups[i + 1].name.substring(0, 3)
                      ? 16.h
                      : 2.h,
                );
              },
              itemCount: groups.length,
            ),
          ),
        ],
      ),
    );
  }
}

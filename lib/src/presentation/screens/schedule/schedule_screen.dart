import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../gen/assets.gen.dart';
import '../../../config/config.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

part './widgets/schedule_week_item.dart';

part './widgets/week_schedule.dart';

part './widgets/daily_schedule.dart';

part './widgets/day_schedule.dart';

part './widgets/exams_schedule.dart';

@RoutePage()
class ScheduleScreen extends StatefulWidget {
  final int id;
  final bool isFavourite;
  final bool isGroupSchedule;
  final String searchingInput;
  final String? title;

  const ScheduleScreen({
    required this.id,
    required this.isFavourite,
    required this.isGroupSchedule,
    required this.searchingInput,
    this.title,
    super.key,
  });

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final scheduleCubit = getIt<ScheduleCubit>();
  final favouriteGroupsCubit = getIt<FavouriteGroupsCubit>();
  final favouriteEmployeesCubit = getIt<FavouriteEmployeesCubit>();

  late final ValueNotifier<bool> favouriteValueNotifier;
  late final ValueNotifier<SubgroupType> subgroupValueNotifier;

  @override
  void initState() {
    super.initState();

    subgroupValueNotifier = ValueNotifier(SubgroupType.all);
    favouriteValueNotifier = ValueNotifier(widget.isFavourite);

    scheduleCubit.fetchSchedule(
      isGroup: widget.isGroupSchedule,
      searchingInput: widget.searchingInput,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;

    return ScreenTemplate(
      body: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: context.pop,
                  child: Assets.icons.arrowLeft.svg(
                    width: 24.w,
                    colorFilter: Colors.black.colorFilter,
                  ),
                ),
                Expanded(
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    tabs: [
                      Assets.icons.schedule.svg(
                        width: 24.w,
                        colorFilter: Colors.grey.colorFilter,
                      ),
                      Assets.icons.calendar.svg(
                        width: 24.w,
                        colorFilter: Colors.grey.colorFilter,
                      ),
                      Assets.icons.school.svg(
                        width: 24.w,
                        colorFilter: Colors.grey.colorFilter,
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: favouriteValueNotifier,
                  builder: (_, isFavourite, __) => IconButton(
                    onPressed: () async {
                      final previous = favouriteValueNotifier.value;

                      if (previous) {
                        if (widget.isGroupSchedule) {
                          await favouriteGroupsCubit
                              .deleteFavouriteGroup(widget.id);
                        } else {
                          await favouriteEmployeesCubit
                              .deleteFavouriteEmployee(widget.id);
                        }
                      } else {
                        if (widget.isGroupSchedule) {
                          await favouriteGroupsCubit
                              .addFavouriteGroup(widget.id);
                        } else {
                          await favouriteEmployeesCubit
                              .addFavouriteEmployee(widget.id);
                        }
                      }

                      favouriteValueNotifier.value = !previous;
                    },
                    icon: Icon(
                      isFavourite ? Icons.star : Icons.star_border_outlined,
                      color: isFavourite ? const Color(0xFFF1CB06) : Colors.grey,
                      size: 24.w,
                    ),
                  ),
                ),
                if (widget.isGroupSchedule)
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: ValueListenableBuilder(
                      valueListenable: subgroupValueNotifier,
                      builder: (_, subgroupFilter, __) => PopupMenuButton(
                        offset: Offset(0, 32.h),
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            onTap: () =>
                                changeSubgroupFilter(SubgroupType.subgroup1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (subgroupFilter == SubgroupType.subgroup1)
                                  const Icon(Icons.check),
                                const Text('Subgroup 1'),
                                Assets.icons.person.svg(
                                  width: 24.w,
                                  colorFilter: Colors.black.colorFilter,
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () =>
                                changeSubgroupFilter(SubgroupType.subgroup2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (subgroupFilter == SubgroupType.subgroup2)
                                  const Icon(Icons.check),
                                const Text('Subgroup 2'),
                                Assets.icons.person.svg(
                                  width: 24.w,
                                  colorFilter: Colors.black.colorFilter,
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () => changeSubgroupFilter(SubgroupType.all),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (subgroupFilter == SubgroupType.all)
                                  const Icon(Icons.check),
                                const Text('All'),
                                Assets.icons.group.svg(
                                  width: 24.w,
                                  colorFilter: Colors.black.colorFilter,
                                ),
                              ],
                            ),
                          ),
                        ],
                        child: subgroupFilter.icon,
                      ),
                    ),
                  )
                else
                  SizedBox(width: 24.w),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              widget.title ?? widget.searchingInput,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: BlocBuilder(
                bloc: scheduleCubit,
                builder: (_, state) {
                  if (state is! ScheduleUpdate) {
                    return const AppLoader();
                  }

                  final schedule = state.schedule;

                  if (schedule == null || (schedule.schedules == null)) {
                    return const Column(
                      children: [
                        Text('No schedule'),
                      ],
                    );
                  }

                  return ValueListenableBuilder(
                    valueListenable: subgroupValueNotifier,
                    builder: (_, subgroupFilter, __) => TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _DailySchedule(
                          schedule: schedule,
                          subgroupFilter: subgroupFilter,
                          isGroupSchedule: widget.isGroupSchedule,
                        ),
                        _WeekSchedule(
                          schedule: schedule,
                          subgroupFilter: subgroupFilter,
                          isGroupSchedule: widget.isGroupSchedule,
                        ),
                        _ExamsSchedule(
                          schedule: schedule,
                          isGroupSchedule: widget.isGroupSchedule,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: use_setters_to_change_properties
  void changeSubgroupFilter(SubgroupType subgroupType) =>
      subgroupValueNotifier.value = subgroupType;

  @override
  void dispose() {
    subgroupValueNotifier.dispose();
    scheduleCubit.close();

    super.dispose();
  }
}

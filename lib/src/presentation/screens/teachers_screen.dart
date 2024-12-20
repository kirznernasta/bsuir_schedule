import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../router/router.dart';
import '../../config/config.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

@RoutePage()
class TeachersScreen extends StatefulWidget {
  const TeachersScreen({super.key});

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  final employeesCubit = getIt<EmployeesCubit>();
  final favouriteEmployeesCubit = getIt<FavouriteEmployeesCubit>();

  late final FocusNode focusNode;
  late final TextEditingController searchController;

  List<int> favouriteIds = [];

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    searchController = TextEditingController();

    employeesCubit.fetchAllEmployees();
    favouriteEmployeesCubit.fetchFavouriteEmployees();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;
    final separator = SizedBox(height: 2.h);

    return ScreenTemplate(
      body: Column(
        children: [
          Text('All teachers', style: textTheme.headlineMedium),
          SizedBox(height: 16.h),
          Expanded(
            child: BlocBuilder(
              bloc: employeesCubit,
              builder: (_, state) {
                if (state is! EmployeesUpdate) {
                  return const AppLoader();
                }

                final allEmployees = state.allEmployees;
                final filteredEmployees = state.filteredEmployees;

                return Column(
                  children: [
                    InputFormField(
                      focusNode: focusNode,
                      hintText: 'Find a teacher',
                      prefixIcon: Assets.icons.search,
                      onInputChanged: (text) {
                        employeesCubit.filterEmployees(text);

                        return '';
                      },
                      onInputCompleted: (text) async {
                        employeesCubit.filterEmployees(text);

                        return '';
                      },
                      textEditingController: searchController,
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: ListView(
                        children: [
                          BlocBuilder(
                            bloc: favouriteEmployeesCubit,
                            builder: (_, state) {
                              if (state is! FavouriteEmployeesUpdate) {
                                return const SizedBox();
                              }
                              favouriteIds = state.employeesIds;

                              if (favouriteIds.isEmpty) return const SizedBox();

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Favourites ⭐️'),
                                  SizedBox(height: 16.h),
                                  for (var i = 0;
                                      i < favouriteIds.length;
                                      i++) ...[
                                    _EmployeeCard(
                                      employee: allEmployees.firstWhere(
                                        (employee) =>
                                            employee.id == favouriteIds[i],
                                      ),
                                      isFavourite: true,
                                      hasTopRounded: i == 0,
                                      hasBottomRounded:
                                          i == favouriteIds.length - 1,
                                    ),
                                    if (i < favouriteIds.length - 1)
                                      SizedBox(height: 2.h),
                                  ],
                                  SizedBox(height: 16.h),
                                ],
                              );
                            },
                          ),
                          if (filteredEmployees.isNotEmpty)
                            for (var i = 0; i < filteredEmployees.length; i++)
                              Builder(
                                builder: (_) => Column(
                                  children: [
                                    _EmployeeCard(
                                      employee: filteredEmployees[i],
                                      hasTopRounded: i == 0,
                                      hasBottomRounded:
                                          i == filteredEmployees.length - 1,
                                      isFavourite: favouriteIds
                                          .contains(filteredEmployees[i].id),
                                    ),
                                    if (i < filteredEmployees.length - 1)
                                      separator,
                                  ],
                                ),
                              )
                          else
                            NoSearchResult(searchInput: searchController.text),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    employeesCubit.close();

    super.dispose();
  }
}

class _EmployeeCard extends StatelessWidget {
  final bool isFavourite;
  final bool hasTopRounded;
  final bool hasBottomRounded;
  final EmployeeEntity employee;

  const _EmployeeCard({
    required this.employee,
    required this.isFavourite,
    required this.hasTopRounded,
    required this.hasBottomRounded,
  });

  @override
  Widget build(BuildContext context) {
    final titleTexts = [
      employee.lastName,
      employee.firstName,
      if (employee.middleName != null) employee.middleName,
    ];

    return AppCard(
      title: titleTexts.join(' '),
      hasTopRounded: hasTopRounded,
      hasBottomRounded: hasBottomRounded,
      suffix: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Image.network(
          employee.imageUrl,
          width: 48.w,
          height: 48.w,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Assets.icons.placeholder.image(
            width: 48.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () => context.pushRoute(
        ScheduleRoute(
          id: employee.id,
          title: employee.fio,
          isGroupSchedule: false,
          isFavourite: isFavourite,
          searchingInput: employee.urlId,
        ),
      ),
    );
  }
}

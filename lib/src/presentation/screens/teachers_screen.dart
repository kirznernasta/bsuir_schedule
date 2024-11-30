import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../router/router.dart';
import '../../config/config.dart';
import '../presentation.dart';

@RoutePage()
class TeachersScreen extends StatefulWidget {
  const TeachersScreen({super.key});

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  final employeesCubit = getIt<EmployeesCubit>();

  late final FocusNode focusNode;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    searchController = TextEditingController();

    employeesCubit.fetchAllEmployees();
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

                final employees = state.employees;

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
                    if (employees.isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                          itemCount: employees.length,
                          separatorBuilder: (_, i) => separator,
                          itemBuilder: (_, i) {
                            final employee = employees[i];
                            final titleTexts = [
                              employee.lastName,
                              employee.firstName,
                              if (employee.middleName != null)
                                employee.middleName,
                            ];

                            return AppCard(
                              hasTopRounded: i == 0,
                              title: titleTexts.join(' '),
                              hasBottomRounded: i == employees.length - 1,
                              suffix: ClipRRect(
                                borderRadius: BorderRadius.circular(24.r),
                                child: Image.network(
                                  width: 48.w,
                                  height: 48.w,
                                  employee.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      Assets.icons.placeholder.image(
                                    width: 48.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () => context.pushRoute(
                                ScheduleRoute(
                                  isGroupSchedule: false,
                                  searchingInput: employee.urlId,
                                  title:
                                      '${employee.lastName} ${employee.firstName[0]} ${employee.middleName?[0] ?? ''}',
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    else
                      NoSearchResult(searchInput: searchController.text),
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

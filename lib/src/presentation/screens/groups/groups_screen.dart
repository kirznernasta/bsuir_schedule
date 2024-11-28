import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';
import '../../../config/config.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

part './widgets/group_card.dart';

@RoutePage()
class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final groupsCubit = getIt<GroupsCubit>();

  late final FocusNode focusNode;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    searchController = TextEditingController();

    groupsCubit.fetchAllGroups();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;

    return ScreenTemplate(
      body: Column(
        children: [
          Text('All groups', style: textTheme.headlineMedium),
          SizedBox(height: 16.h),
          Expanded(
            child: BlocBuilder(
              bloc: groupsCubit,
              builder: (_, state) {
                if (state is! GroupsUpdate) {
                  return const AppLoader();
                }

                final groups = state.groups;

                return Column(
                  children: [
                    InputFormField(
                      focusNode: focusNode,
                      hintText: 'Find the group',
                      prefixIcon: Assets.icons.search,
                      onInputChanged: (text) {
                        groupsCubit.filterByGroupNumber(text);

                        return '';
                      },
                      onInputCompleted: (text) async {
                        groupsCubit.filterByGroupNumber(text);

                        return '';
                      },
                      textEditingController: searchController,
                    ),
                    SizedBox(height: 16.h),
                    if (groups.isNotEmpty)
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
                              final previousCode =
                                  previousGroup.name.substring(0, 3);
                              hasTopRounded |= previousCode != currentCode;
                            }
                            if (i < groups.length - 1) {
                              final nextGroup = groups[i + 1];
                              final nextCode = nextGroup.name.substring(0, 3);
                              hasBottomRounded |= nextCode != currentCode;
                            }

                            return _GroupCard(
                              group: group,
                              hasTopRounded: hasTopRounded,
                              hasBottomRounded: hasBottomRounded,
                            );
                          },
                          separatorBuilder: (_, i) {
                            final currentCode = groups[i].name.substring(0, 3);
                            final nextCode = groups[i + 1].name.substring(0, 3);

                            return SizedBox(
                              height: currentCode != nextCode ? 16.h : 2.h,
                            );
                          },
                          itemCount: groups.length,
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
    groupsCubit.close();

    super.dispose();
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../router/router.dart';
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
  final favouriteGroupsCubit = getIt<FavouriteGroupsCubit>();

  late final FocusNode focusNode;
  late final TextEditingController searchController;

  List<int> favouriteIds = [];

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    searchController = TextEditingController();

    groupsCubit.fetchAllGroups();
    favouriteGroupsCubit.fetchFavouriteGroups();
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

                final allGroups = state.allGroups;
                final filteredGroups = state.filteredGroups;

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
                    Expanded(
                      child: ListView(
                        children: [
                          BlocBuilder(
                            bloc: favouriteGroupsCubit,
                            builder: (_, state) {
                              if (state is! FavouriteGroupsUpdate) {
                                return const SizedBox();
                              }
                              favouriteIds = state.groupsIds;

                              if (favouriteIds.isEmpty) return const SizedBox();

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Favourites ⭐️'),
                                  SizedBox(height: 16.h),
                                  for (var i = 0;
                                      i < favouriteIds.length;
                                      i++) ...[
                                    _GroupCard(
                                      group: allGroups.firstWhere(
                                        (group) => group.id == favouriteIds[i],
                                      ),
                                      isFavourite: true,
                                      hasCodeText: false,
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
                          if (filteredGroups.isNotEmpty) ...[
                            for (var i = 0; i < filteredGroups.length; i++)
                              Builder(
                                builder: (_) {
                                  final isFirst = i == 0;
                                  final isLast = i == filteredGroups.length - 1;
                                  final group = filteredGroups[i];
                                  var hasTopRounded = isFirst;
                                  var hasBottomRounded = isLast;
                                  final currentCode =
                                      group.name.substring(0, 3);

                                  if (i > 0) {
                                    final previousGroup = filteredGroups[i - 1];
                                    final previousCode =
                                        previousGroup.name.substring(0, 3);
                                    hasTopRounded |=
                                        previousCode != currentCode;
                                  }
                                  if (i < filteredGroups.length - 1) {
                                    final nextGroup = filteredGroups[i + 1];
                                    final nextCode =
                                        nextGroup.name.substring(0, 3);
                                    hasBottomRounded |= nextCode != currentCode;
                                  }
                                  return Column(
                                    children: [
                                      _GroupCard(
                                        group: group,
                                        isFavourite: favouriteIds.contains(
                                          group.id,
                                        ),
                                        hasTopRounded: hasTopRounded,
                                        hasBottomRounded: hasBottomRounded,
                                      ),
                                      if (i < filteredGroups.length - 1)
                                        SizedBox(
                                          height: currentCode !=
                                                  filteredGroups[i + 1]
                                                      .name
                                                      .substring(0, 3)
                                              ? 16.h
                                              : 2.h,
                                        ),
                                    ],
                                  );
                                },
                              ),
                          ] else
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
    groupsCubit.close();
    favouriteGroupsCubit.close();

    super.dispose();
  }
}

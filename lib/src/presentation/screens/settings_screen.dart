import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../router/router.dart';
import '../../config/config.dart';
import '../presentation.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final userCubit = getIt<UserCubit>();

  @override
  void initState() {
    super.initState();

    userCubit.fetchAccountInfo();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;

    return ScreenTemplate(
      body: Column(
        children: [
          Text('Settings', style: textTheme.headlineMedium),
          SizedBox(height: 16.h),
          BlocBuilder(
            bloc: userCubit,
            builder: (_, UserState state) {
              if (state is UserInProgress) {
                return const AppLoader();
              }

              final hasAccount = state is UserUpdate && state.hasAccount;

              if (hasAccount) {
                return Expanded(
                  child: Column(
                    children: [
                      AppCard(
                        hasPrefix: false,
                        hasTopRounded: true,
                        hasBottomRounded: false,
                        subtitle: 'Your account',
                        title: state.email ?? '',
                      ),
                      SizedBox(height: 2.h),
                      AppCard(
                        title: 'Exit',
                        hasTopRounded: false,
                        hasBottomRounded: true,
                        onTap: () {
                          context.pushRoute(const ExitConfirmationRoute());
                        },
                      ),
                    ],
                  ),
                );
              }

              return const _AddAccountContent();
            },
          ),
        ],
      ),
    );
  }
}

class _AddAccountContent extends StatelessWidget {
  const _AddAccountContent();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.theme.primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.all(10.r),
            child: Column(
              children: [
                Text(
                  'You do not have an account',
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.bodyLarge,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Add an account to add to favourites group and employee to easier see their schedules.',
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 48.h,
            width: MediaQuery.sizeOf(context).width,
            child: FilledButton(
              onPressed: () {
                context.pushRoute(const SignInRoute());
              },
              child: const Text(
                'Add an account',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

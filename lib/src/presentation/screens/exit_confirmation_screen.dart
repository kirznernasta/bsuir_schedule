import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/config.dart';
import '../presentation.dart';

@RoutePage()
class ExitConfirmationScreen extends StatefulWidget {
  const ExitConfirmationScreen({super.key});

  @override
  State<ExitConfirmationScreen> createState() => _ExitConfirmationScreenState();
}

class _ExitConfirmationScreenState extends State<ExitConfirmationScreen> {
  final userCubit = getIt<UserCubit>();

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      body: Column(
        children: [
          const Spacer(),
          Text(
            'Are you sure you want to exit?',
            textAlign: TextAlign.center,
            style: context.theme.textTheme.headlineLarge,
          ),
          SizedBox(height: 16.h),
          Text(
            "You won't be able to see your favourites schedules.",
            textAlign: TextAlign.center,
            style: context.theme.textTheme.bodyLarge,
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: BlocBuilder(
                  bloc: userCubit,
                  buildWhen: (_, UserState current) {
                    if (current is UserError) {
                      Fluttertoast.showToast(
                        msg: 'Error! Please try again.',
                        gravity: ToastGravity.TOP,
                        backgroundColor:const Color(0xFF7A0808),
                      );
                    } else if (current is UserUpdate && !current.hasAccount) {
                      context.pop();
                    }

                    return true;
                  },
                  builder: (_, UserState state) {
                    final isInProgress = state is UserInProgress;

                    return OutlinedButton(
                      onPressed: isInProgress ? null : userCubit.signOut,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isInProgress) const CircularProgressIndicator(),
                          const Text('Exit'),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: FilledButton(
                  onPressed: context.pop,
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

part of './user_cubit.dart';

sealed class UserState {}

class UserInitial extends UserState {}

class UserInProgress extends UserState {}

class UserError extends UserState {}

class UserUpdate extends UserState {
  final bool hasAccount;
  final String? email;

  UserUpdate({required this.hasAccount, this.email});
}

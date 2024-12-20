import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../config/config.dart';
import '../../../domain/domain.dart';
import '../blocs.dart';

part './user_state.dart';

@lazySingleton
class UserCubit extends Cubit<UserState> {
  final ApplicationRepository _applicationRepository;

  UserCubit(this._applicationRepository) : super(UserInitial());

  Future<void> fetchAccountInfo() async {
    emit(UserInProgress());

    final hasAccount = await _applicationRepository.hasAccount;

    if (isClosed) return;

    emit(
      UserUpdate(
        hasAccount: hasAccount,
        email: _applicationRepository.email,
      ),
    );
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(UserInProgress());

    final isSuccessful = await _applicationRepository.createUser(
      email: email,
      password: password,
    );

    if (isClosed) return;

    if (isSuccessful) {
      emit(UserUpdate(hasAccount: true, email: email));
    } else {
      emit(UserError());
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(UserInProgress());

    final isSuccessful = await _applicationRepository.findUser(
      email: email,
      password: password,
    );

    await getIt<FavouriteGroupsCubit>().fetchFavouriteGroups();
    await getIt<FavouriteEmployeesCubit>().fetchFavouriteEmployees();

    if (isClosed) return;

    if (isSuccessful) {
      emit(UserUpdate(hasAccount: true, email: email));
    } else {
      emit(UserError());
    }
  }

  Future<void> signOut() async {
    emit(UserInProgress());

    final isSuccessful = await _applicationRepository.deleteUserInfo();

    await getIt<FavouriteGroupsCubit>().fetchFavouriteGroups();
    await getIt<FavouriteEmployeesCubit>().fetchFavouriteEmployees();

    if (isClosed) return;

    if (isSuccessful) {
      emit(UserUpdate(hasAccount: false));
    } else {
      emit(UserError());
    }
  }
}

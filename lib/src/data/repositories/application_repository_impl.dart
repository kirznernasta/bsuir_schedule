import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';
import '../data.dart';

@LazySingleton(as: ApplicationRepository)
class ApplicationRepositoryImpl implements ApplicationRepository {
  final ScheduleDataSource _scheduleDataSource;
  final AppSettingsLocalDataSource _appSettingsLocalDataSource;

  ApplicationRepositoryImpl(
    this._scheduleDataSource,
    this._appSettingsLocalDataSource,
  );

  bool? _hasAccount;

  @override
  Future<bool> deleteUserInfo() {
    return _appSettingsLocalDataSource.deleteUserInfo();
  }

  @override
  String? get email => _appSettingsLocalDataSource.email;

  @override
  String? get passwordHash => _appSettingsLocalDataSource.passwordHash;

  Future<void> _saveUserInfo({
    required String email,
    required String passwordHash,
  }) {
    return _appSettingsLocalDataSource.saveUserInfo(
      email: email,
      passwordHash: passwordHash,
    );
  }

  @override
  Future<bool> get hasAccount async {
    if (_hasAccount != null) return _hasAccount!;

    final email = _appSettingsLocalDataSource.email;

    if (email == null) return false;

    final passwordHash = _appSettingsLocalDataSource.passwordHash;

    if (passwordHash == null) return false;

    final isFound = await _scheduleDataSource.findUser(
      email: email,
      passwordHash: passwordHash,
    );

    if (!isFound) {
      await deleteUserInfo();

      return false;
    }

    return true;
  }

  @override
  Future<bool> createUser({
    required String email,
    required String password,
  }) async {
    final passwordBytes = utf8.encode(password);
    final passwordHash = sha1.convert(passwordBytes).toString();

    final isCreated = await _scheduleDataSource.createUser(
      email: email,
      passwordHash: passwordHash,
    );

    if (isCreated) {
      await _saveUserInfo(email: email, passwordHash: passwordHash);
      _hasAccount = true;
    }

    return isCreated;
  }

  @override
  Future<bool> findUser({
    required String email,
    required String password,
  }) async {
    final passwordBytes = utf8.encode(password);
    final passwordHash = sha1.convert(passwordBytes).toString();

    final isFound = await _scheduleDataSource.findUser(
      email: email,
      passwordHash: passwordHash,
    );

    if (isFound) {
      await _saveUserInfo(email: email, passwordHash: passwordHash);
      _hasAccount = true;
    }

    return isFound;
  }
}

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data.dart';

@injectable
class AppSettingsLocalDataSource {
  final SharedPreferences _sharedPrefs;

  const AppSettingsLocalDataSource(this._sharedPrefs);

  static String? _email;
  static String? _passwordHash;

  @postConstruct
  void init() {
    _restoreUserInfo();
  }

  String? get email => _email;

  String? get passwordHash => _passwordHash;

  bool get hasSavedAccount => _email != null && _passwordHash != null;

  Future<void> saveUserInfo({
    required String email,
    required String passwordHash,
  }) async {
    const accessKey = LocalStorageKeys.email;
    const refreshKey = LocalStorageKeys.passwordHash;

    await _sharedPrefs.setString(accessKey, email);
    await _sharedPrefs.setString(refreshKey, passwordHash);

    _email = email;
    _passwordHash = passwordHash;
  }

  Future<bool> deleteUserInfo() async {
    const emailKey = LocalStorageKeys.email;
    const passwordHashKey = LocalStorageKeys.passwordHash;

    final isEmailDeleted = await _sharedPrefs.remove(emailKey);
    final isPasswordHashDeleted = await _sharedPrefs.remove(passwordHashKey);

    if (isEmailDeleted) _email = null;

    if (isPasswordHashDeleted) _passwordHash = null;

    return isEmailDeleted && isPasswordHashDeleted;
  }

  void _restoreUserInfo() {
    const accessKey = LocalStorageKeys.email;
    const refreshKey = LocalStorageKeys.passwordHash;

    _email = _sharedPrefs.getString(accessKey);
    _passwordHash = _sharedPrefs.getString(refreshKey);
  }
}

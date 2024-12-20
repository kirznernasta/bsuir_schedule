abstract class ApplicationRepository {
  String? get email;

  String? get passwordHash;

  Future<bool> deleteUserInfo();

  Future<bool> get hasAccount;

  Future<bool> createUser({required String email, required String password});

  Future<bool> findUser({required String email, required String password});
}

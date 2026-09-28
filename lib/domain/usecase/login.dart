import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/repository/auth_repository.dart';

/// 로그인.
@injectable
class Login {
  const Login(this._repository);

  final AuthRepository _repository;

  Future<void> call({required String email, required String password}) =>
      _repository.login(email: email, password: password);
}

import '../models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'teste@email.com' && password == '123456') {
      return UserModel(name: 'Usuário Teste', email: email, token: 'mock_token_12345');
    } else {
      throw Exception('Credenciais Inválidas');
    }
  }
}

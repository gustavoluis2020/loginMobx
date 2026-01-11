import 'package:mobx/mobx.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/entities/user_entity.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final LoginUseCase loginUseCase;

  LoginStoreBase(this.loginUseCase);

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  UserEntity? user;

  @observable
  bool isPasswordVisible = false;

  @action
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }

  @action
  void setEmail(String value) {
    email = value;
    errorMessage = null;
  }

  @action
  void setPassword(String value) {
    password = value;
    errorMessage = null;
  }

  @computed
  bool get isEmailValid => RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  String? get emailError {
    if (email.isEmpty) return null;
    return isEmailValid ? null : 'Email inválido';
  }

  @computed
  String? get passwordError {
    if (password.isEmpty) return null;
    return isPasswordValid ? null : 'Senha precisa ter no minimo 6 caracteres';
  }

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid && !isLoading;

  @action
  Future<void> login() async {
    if (!isFormValid) return;

    isLoading = true;
    errorMessage = null;

    final result = await loginUseCase(LoginParams(email: email, password: password));

    result.fold(
      (failure) {
        errorMessage = failure.message;
        isLoading = false;
      },
      (success) {
        user = success;
        isLoading = false;
      },
    );
  }
}
